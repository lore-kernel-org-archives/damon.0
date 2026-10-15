Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAD284693;
	Thu, 15 Oct 2026 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073608; cv=none; b=m8U6xYJBL4wKeyMP13OLKY6+tiqPOSINNQtOJbAZDk4U2k8Wz+M253AzFqjHmpmNBEma2cenHYaSNHhEMEMw0NQyYET19ovycWTUUnc8mh3yuXS/iuxhdMQ81BLcvoP3sHeiIHxQHNc9Xlt+j4Xah9Z7gxu0hgVXBxFWfY2oAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073608; c=relaxed/simple;
	bh=qk7EObw9jegCCoMHdhDr7g/VY2GLHs0vSQ3vyS3zVUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMomYeD51XWh9pn8zYmVP211NNzTkeuaaa3wV19P/6nRqqo8eUwxchGCsQ8gwT7m++NqA/2BCFIl1ygd/EOq//HFVtifwjId+E1bYz1Hw2Omo24hrTDfQpManPzlrBEos29s1WGTBytHUQT0wOU7A1py84Z0m1x1viMQneI22XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK2jk6qM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK2jk6qM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C5F1F000C4;
	Thu, 15 Oct 2026 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073606;
	bh=vSbVaC0f2gNWsRFqnc1zPjJqFLHG96Rj4dv0cQbpqHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VK2jk6qMdVNH/RTkBn4PiZI8l5MImtqd3I3/rcyPP3Z0H9vIq89Aqw22/KwApHpvq
	 sq8EsJleJfgC6Cjn62uzJ0PV5sSqtxM5ZHTry/w8PU8mlXfWxmH9jGrONj71JsufQn
	 BdVquPDJF368SCGof+kurkib3QSmOjvG/gWWEwXssUECfiN/Re+GlMjz62a1bxPFDV
	 XgCdx/GqOrPGwHc8J29qkAlYhs9rU6NH0I4eWzlJw1qNGsNbubg51pUq0zBCzySD1j
	 R16wu5PI+4GtNFfiN9cHyLrRR1T1D7o65TYAd88FFUWkm5QxeduSsN9z66q/PyV3jm
	 32hAyDmOWkq1w==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] DAMON_STAT: idle percentiles out of order on 32-bit
Date: Thu, 15 Oct 2026 07:13:19 -0700
Message-ID: <20261015141319.88393-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmHad1vamnZT12M5yPrJ69==Pt1U0+MGw6u0MuNtr-DRCw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Avelin,

On Thu, 15 Oct 2026 04:24:12 -0700 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi,
> 
> In an i386 QEMU guest built from mm-new commit ad9f2d463666,
> DAMON_STAT reported these memory_idle_ms_percentiles values after a
> statistics update:
> 
>   guest uptime:       22.51 s
>   aggr_interval_us:   3200000
>   percentile 0:      19200 ms
>   percentile 50:         0 ms
>   percentile 100:        0 ms
> 
> The 0th percentile is greater than the 50th and 100th.  The guest had
> 256 MiB of RAM (MemTotal: 254216 kB), a running kdamond,
> CONFIG_X86_32=y, CONFIG_DAMON_STAT=y,
> CONFIG_DAMON_STAT_ENABLED_DEFAULT=y, and CONFIG_COMPAT_32BIT_TIME=y.
> aggr_interval_us changed from 0 to 1600000 and then 3200000, showing
> that statistics updates ran before the final read.
> 
> In damon_stat_set_idletime_percentiles(), the loop compares
> 
>   next_percentile <= accounted_bytes * 100 / total_sz
> 
> where accounted_bytes and total_sz are unsigned long.  On 32-bit, when
> total_sz exceeds 42,949,672 bytes, the wrapped product cannot yield
> 100%, even after all bytes are accounted for.  Upper entries in
> memory_idle_ms_percentiles then retain an earlier value or remain zero
> on first use.  DAMON_STAT monitors the system RAM address range, which
> exceeds that threshold in this guest.  I did not capture a per-region
> trace in this run.
> 
> The guest init read the module parameters after 22 seconds of uptime;
> it did not write to them.  The i386 config, guest init, serial log, and
> build/run steps:

Could you share more details about your real use case that require the setup
and how this becomes a real problem?


Thanks,
SJ

[...]
