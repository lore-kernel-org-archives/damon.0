Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8694F7CAE;
	Thu, 15 Oct 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073690; cv=none; b=qGfPcIhpw93qqCy+iJb9BhW56evcuY2a9BI3PnwPjNs6sg8ga95irWW488SOwIszFurpKQwh1Js9IMzdjIAAuxjvldtQIy/reicA7rGZabhGNEu4qvuTPYe8+FoNnjvgoB5H4syv7sR76rZC58zo+sqXusaesxBd6ZrbNhpgtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073690; c=relaxed/simple;
	bh=BVD1Vz+UeJLrV2fGsYYdBVUZNTV2X12KZNuySUMivPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy4bzbxgSaSeBDyyFvq9V8owZXDGyqsCjghIBKH2U1eAwua9rHilW34P3k6cfs5BpuwtT24si5S3+NEZC3gistG+3XKe0qnN8qKbCMngsSpfduc1lxEHH88N8UHLUtKzdforruw23Ks32s8CNgVpVcsks69B5A/CnkHaITz44eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7oT4j2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7oT4j2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AAB1F000C4;
	Thu, 15 Oct 2026 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073688;
	bh=dEbkmTWrpR6q9/sWzznVAOdz9b4w+GRgYvyg0dkV3XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7oT4j2M/dxRJ5UNhePstb/qD65RJhAQPsJrp+OXO3aFNyn0N4VRuUNGOX8hLBunf
	 UyM7SVGnVPwsvtkw0f3lrVZT4exY43JBzW0zo6cW/wXCLEUThDQZpWnUiftQ/ysYb5
	 Wqhz5xrSpYdlnU63hDvFwcLOoBKxQ18mkZMNRq4ZQGPWR9nlaohdt3b7nKzihXv+OQ
	 8Yzi8UIkB/f+hMP9lgRzHgEx2fCTSlvK9Tvzlj9S9rwiJpyboAwbvE0ZebUUXTb3Jd
	 ukYMmmSomSgg/NxQSSqymmh8CC8QrQ3oNjoxhLcASqIhKEeTByRiBwDmlz7MvTVXTD
	 mAfZLXzrwXufg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] DAMON_STAT: 32-bit overflow reports wrong estimated bandwidth
Date: Thu, 15 Oct 2026 07:14:41 -0700
Message-ID: <20261015141442.88741-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmFPJt=-=hJh9Gt-FPG6YiyeidyfUbnW0mF5bSmJ0m7P0w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Aveline,

On Thu, 15 Oct 2026 04:24:19 -0700 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi,
> 
> On an unmodified i386 QEMU kernel at mm-new commit ad9f2d463666,
> DAMON_STAT reported an incorrect estimated_memory_bandwidth value.
> CONFIG_DAMON_STAT=y and CONFIG_DAMON_STAT_ENABLED_DEFAULT=y were set.
> The guest continuously wrote one byte per page across a 32 MiB mapping.
> I used QEMU's GDB stub and the matching vmlinux to stop just after
> damon_stat_set_estimated_memory_bandwidth() stored its result.  At each
> stop, I traversed the same target's regions separately and recomputed
> access_bytes with full-width integers.
> 
> Three nonzero callbacks, all with aggr_interval=100000 us, showed:
> 
>   access_bytes   independent sum   stored B/s   full-width B/s
>       33357824          33357824        31079        333578240
>       65200128          65200128        25244        652001280
>       41152512          41152512        24303        411525120
> 
> The final sysfs read was estimated_memory_bandwidth=24303, matching the
> last stored value.  The independent region sum matched the kernel's
> access_bytes in every callback, so the sum had not overflowed.  Each
> full-width result fits a 32-bit unsigned long.
> 
> In mm/damon/stat.c, the expression multiplies the unsigned long
> access_bytes by 1000000 before dividing by the aggregation interval.
> On i386 the product wraps.  In the first row it becomes 3107979264;
> dividing by 100000 gives the stored value, 31079.  Full-width arithmetic
> gives 333578240 B/s from the same inputs.  The other two rows show the
> same problem at the callback site.
> 
> The workload is synthetic; the test checks DAMON_STAT's arithmetic, not
> the accuracy of its traffic estimate.  The i386 config, guest init,
> disassembly, GDB probe, logs, and build/run steps are here:

Could you share more details about your use case that require this setup, and
how this becomes a problem?


Thanks,
SJ

[...]
