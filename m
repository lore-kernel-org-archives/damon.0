Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47C338936;
	Tue, 11 Aug 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456623; cv=none; b=ew6N8zxwo4m6E48xOYdKFffAMAXNtDB4/GVorWJbE4wyHugBefJKt4a9RJdK4Ov/qMsPHfKrcp5ZbBz2fy7Ll/NlxiQHuxQoIljnoOWELPG8is6pieGhTefw23xBQhishIstTGjXEAS5nPIZsRA3jilfQn94mnVfTmr0NlIQHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456623; c=relaxed/simple;
	bh=RuxuWqw8ZT/3jujeSRkcp5XdHSNKvThdpngKT9ZfhgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8hcfJez5QNFw1gJpBgMM28GUK62THOsmAFoZ26apo9mnk85asqpFYtDeEKHtOYWht6Oo0mpNQpMoVOc4DVyrgZZuhQ52dmqV/p51hCEbIL/uuIHg0J4iykp+/CqsLXcaUaTwi6CFFaP39W5mhw8nmT171YNTnSasHtjK76XNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbm1G6jB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbm1G6jB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E6E1F000E9;
	Tue, 11 Aug 2026 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456621;
	bh=1EZys2aqS7rZM1vX2mH2UpGd0DfOQWYKd3PES5jlHzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tbm1G6jB7U0RLXAMd6QA/yQkQ3/AttRY+CFxiV/rY4vrq9eYO8ecMDJlLnA3vL4o9
	 Y0pofMBO7YFPumBy/x66NWf30thw/+ObLnq7Ggo7sQyNwTfnYG7ZjMhZKi61s1U2QB
	 mCdYb3Y33I98WoDGgLLNBOmvklgqr11xFkol+UeKdsv32wyGoKvWTn+1RaOZx1iAZ8
	 1M+Uc0DkN7QUeESD/WeqAblOuXZXLcoUiWeQ5kasciC5GzE00L99nxsp0RfUQWs0om
	 0K6dFl7Rm6XFuPyLZZyLDKyh+sIl8Ec0gIfrZ40fDxTw0U10KjL0KnT5gYpz5WT8sW
	 S/ev13yt3u6lA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Tue, 11 Aug 2026 06:56:53 -0700
Message-ID: <20260811135654.4901-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811101841.804596-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,


'hkml patch check' [1] says you forgot Cc-ing below people who are recommended
by get_maintainer.pl.  Please Cc all recipients who
get_maitnainer.pl is recommending, from the next time.  'hkml patch format' [2]
could also help you doing so.

I added the missing recipients to this mail's recipients.  Because this series
is a minor change for only DAMON documentation, I didn't add them to the
patches.  People who are interested in reviewing the patches can find them from
lore.kernel.org.

- Andrew Morton <akpm@linux-foundation.org>
- David Hildenbrand <david@kernel.org>
- Lorenzo Stoakes <ljs@kernel.org>
- "Liam R. Howlett" <liam@infradead.org>
- Vlastimil Babka <vbabka@kernel.org>
- Mike Rapoport <rppt@kernel.org>
- Suren Baghdasaryan <surenb@google.com>
- Michal Hocko <mhocko@suse.com>
- Jonathan Corbet <corbet@lwn.net>
- Shuah Khan <skhan@linuxfoundation.org>
- linux-doc@vger.kernel.org
- linux-kernel@vger.kernel.org

On Tue, 11 Aug 2026 18:18:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Add an explanation of nr_snapshots to avoid misunderstandings.

Thank you for this patch series, Liew.

> 
> Liew Rui Yan (3):
>   docs/mm/damon/design: accurate semantics of nr_snapshots
>   docs/mm/damon/design: difference between watermarks and nr_snapshots
>   docs/mm/damon/design: fix typo of max_nr_snapshots

I requested changes to patches 1 and 2 via replies.

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#checking-patches
[2] https://github.com/sjp38/hackermail/blob/master/USAGE.md#formatting-patches


Thanks,
SJ

[...]
