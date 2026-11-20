Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795134096;
	b=aSCmzCiiBMneQCMwBmCnti8ZbBtuQtLx/XcuVTifWde5USUOQgEtM/DBNzB4Xqg/1i8s
	 J+mEEodRrQf/5O0qEYI5Gkb19UDwxBaDpG3eKXG6VV1XwZpa/MDzZZ24EWyu8swVrcZeE
	 azZaxfWsH8UqMgr3EkVRZddk0v+VAG2IQdUB4GrYf9aX5h6AfEYOqzMJKwNqbUJtx3EWb
	 CcxaOPuBWHLpjo+MzB2oN5UfzwMABw4V+EuAmn7RnhTYztuV35Na4z4ijBKZzb4hKfw/j
	 N+F8kb3hPn+WlL1JI5GRc1/4boBDqI/bVDYz5pJaDNLZFXv3eZYtwaoyoIZUpabxrKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0CZfHhfHfESc4YrPufMYXO8QeXfOTlDtABpZbDYX5SI=;
	b=SR6QT/ebkQxhIU7cZjQY1TjfZM53fHzSBrBPV7CcjoKIFQrjI7RUpstCoUtKJtuhiDYm
	 lT18H7wxl/kjUwc9SH3Yd7zV9nx+vsHzSH9w9AlKK5sZAYbRq67P9E9i/RwEcw4fpZE9U
	 vBs6SofQrphYybjz1bwyi7MFrPY5K3o4S3tBpsH7rlpGPRT9TE9KdVLKerK6AA/i+GF6h
	 xfH4y565LX+XipDwTLDRFym9rX+6xCLsKCy4Hno3euWTxsZs72sQ+kQwDxYsxUaOaWjJ1
	 XMebbdU/Bo5QUMBCLQ+PhyjmEpoOo+iHyiCp+Jqy5oBEB+XJiVBZljhjxLU6gwQxXjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qek5f39Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D533606A326
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D533606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qek5f39Y
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so3702135e9.1
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 16:21:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795134094; cv=none;
        d=google.com; s=arc-20260327;
        b=PtHLSlqHKZKXWGa6fzU0dv4CKIvg9IeQXDmGEnoXYTwSVz6LpFCiwpnybmU7VhFgSk
         4jqBAPHKUkKmQseKndMZ8m2enI5JI5J+tckT1zYLEe8v0QjmfbJwTT1GzcWkpetmUVjb
         IJNPA4dZe6yvzyndDEb/jn6m1jvfsEEAOLFn3bqm2Nz1K2bHqD2mTfi9wbZBr8zguY1u
         8qwmwwPRT8B2GrtVn3Vfhrd4ZeZ25FvtNoS9VbcNzxuZydgbLo1+6o8EnwvXXlUHhF65
         qeK6QBakxyNgEJG1NCcdrIdQV6hFeNpM5dyTDYA90Eq80OGCBDu+W7iGPMwv1NV0fNzq
         AqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0CZfHhfHfESc4YrPufMYXO8QeXfOTlDtABpZbDYX5SI=;
        fh=ktQYFBVoxggXx5MbDqebMBTQuqPXUME2++xsNnpQHrg=;
        b=ZZqqalC5R3xd8U0izJzQMqOHy5QyGeIBqdbgEjf1imtOzo6wn41L8+wWhY7PsdxU6A
         Apq+gWi7t4pojMu7L01m3Hko6Ot4AyK5yoH7cEZCGXTJJKE3SaV4k9OsA1FWANshK3Ye
         UpYhjJ7nRiRy4kUEH2yeR1il/lS8kbJDFMnU1G2Hy4Tq1glorqTurFHD30aX+UfwgXv8
         Pf9lkuKaRZT6M0m7UE0pEUYX7zUYo+mXkq5ISfWCvZ1t3MBbKNwCiomNvn9uwElhy+n1
         JGEPybdSeC3D9gGGkPzOOy7OMikM3e68joGqCVJ9+QRUBTGkFYa4LhKBPdxftVfLk1MS
         93wQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795134094; x=1795738894; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0CZfHhfHfESc4YrPufMYXO8QeXfOTlDtABpZbDYX5SI=;
        b=Qek5f39YlkS89TmXtJUawhhfSe2L617WZOP2M781QBVXm1s1hMYPnC5/56q6SesA/Q
         buO+07Jrt/ItRFCc72UhSD/NHfprW4hW8xJhdt1fdVfbbIf5CnZgIqEs40fEJK9vuCd4
         f4diciAnRBbNDaS9ksY4DYCnwbC9rOndSLU9QYQg2bgl+/IY+kuEoccKbd3sNhCDEZay
         oexoOhlFFDII7MuaQ8z1KG4Hm72P8x4Wn+cSctadiEHOwYU4lOMuyMxi8Mn6RPuHVEYm
         mSCvESPddYiITXEZJtFaPDexnbt8XBabz1BQNsUlsUqDhDAzQrTABd0DiQTMumgGPGvX
         8Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134094; x=1795738894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CZfHhfHfESc4YrPufMYXO8QeXfOTlDtABpZbDYX5SI=;
        b=xg0HhdFXJPdhkKIyQDZIypGSvf+4xkFp5Tv3Wu6r3OqUVNAWsqJXRtWx5nOZgaYISR
         rPhyqpY+BL0TETQzm7yBiSkxZ2TmSGckjKR+l5DKEDCb2XE7cagcD0SIKDLMgxvs3jRi
         Pa/eUXysW59qMUaVMmB8gJIYrCv7tyfusL4xGfXLpm8cvrk1Pvk4NmJOg27vV9l6HozH
         4f2MMOFQoEQktrZ0Ft3KSHWtiwvzT/OUYAAaIj4luy3F7eaKULoRw7wmrmZ7TmytO82x
         2Fm/zoNkyD63zKGQqsTlpTbPK7piYXnKhHdHAXsTP2Uez7101nN4eSgMXcWOvfulgiwI
         8E3g==
X-Forwarded-Encrypted: i=1; AL+hErErFf5h4Lk0dcrlwyjjzn+V+NUV5GkU88ps+uL07UGyQHKRfnWT9akEiDSP4SPdEvOdwD2q9Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/dnraIgbEjnHDElnUwXdUjXr8Fj/m9Q/o4PRsROEj4yVPIJ0Q5
	V3smT95vhssKbs0FK0V0KEFjdpXiLYB3VoxQPSxU0EBk88aEWJ7imaj7w2yTT4RXGrGW9TfvJe4
	1eZ8ja8CsWzln8KSD+5aX/p4zLynJ+io=
X-Gm-Gg: AYBFou3hTau6O2RHI6DSMcJMJ3t9mWnWneTltgXs/Bd9eJ73jzgc4hHvpbVguZRElyI
	BRuSQnrw4mGz4fBvIhDZOQPCFbxVsPzCYG4T3aSTBB0yGoQgCtsLcbJbPRkBSoBXOWOiiZMVBHg
	npkiwU38+WPhqKGCLjzWf2kKY26dcusRiNDZNwJSeylQ0VFNiXQysczeURUhHWwFt/nEKOTRIqk
	saAPgjuPuPHhpnGj7ZhHCY6uavL6EpX5ROU7r9l1iycI5Xpk/WUy56d4eEwaMkxGs3pn2kJQVkP
	IoYNFhBMFlds1Re2riQDXddIkA9h/LcDKg01H6HzMmIirJ4+jiPj5JXpSjbDv6MZXus8hE5YCtL
	2t6uJBDMNGRpFPLjAtIMhEfSxR5Va1U7lz0q8X8Yi0MeWxPYU1SCZFisXEp+1Cz/ZV9mJasHxuX
	8wtFAt9VP0E+4qXgR5c2h14MO0RLDs8J/3PxsMXk9Q
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id
 5b1f17b1804b1-4bb88809950mr27334705e9.17.1795134094416; Thu, 19 Nov 2026
 16:21:34 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
 <20261114002822.1043378-3-joannelkoong@gmail.com> <avvhFAxBcPk5Q6pW@chrisdown.name>
In-Reply-To: <avvhFAxBcPk5Q6pW@chrisdown.name>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Nov 2026 16:21:22 -0800
X-Gm-Features: Aa3M54ocPog8ZiHHSRBMvtbJbL2fyYxbh9unTOuH5y8YoEH3_wTAT4fdm-kxXRI
Message-ID: <CAJnrk1b8cCOVe+4KL1LTUqw3vPE1EiFcELwurzgGPtfkvc8UoQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: memcg: read root lruvec stats from the node counters
To: Chris Down <chris@chrisdown.name>
Cc: akpm@linux-foundation.org, david@kernel.org, yosry@kernel.org, 
	mkoutny@suse.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, ljs@kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:07=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>

Hi Chris,

Thanks for reviewing and testing this series!

> Hi Joanne,
>
> Joanne Koong writes:
> >The exceptions are the kernel memory stats (slab, kernel stack, page
> >tables, secondary page tables and vmalloc), hugetlb, and
> >WORKINGSET_NODERECLAIM, which counts reclaimed xarray nodes (slab
> >objects). Their node counters also count memory that isn't charged to a
> >memcg, which falls into two categories:
>
> This still describes the v2 denylist. With the allowlist, the root memcg
> also keeps reading rstat for NR_ANON_MAPPED, NR_FILE_MAPPED, NR_SHMEM et
> al, and some of those differ for reasons outside the two categories here,
> like swapcache being counted differently in the node counter, for
> example. Could the changelog say what is on the list instead? So that
> would be the stats that only change through mod_lruvec_state(), with
> everything else still reading rstat.

Will do!

>
> >+      case PGROTATE_ANON:
> >+      case PGROTATE_FILE:
> >+      case PGREFILL:
> >+              return true;
>
> NR_VMSCAN_WRITE isn't on the list, but prepare_scan_control() adds it to
> WORKINGSET_RESTORE_ANON, so once the root flush in reclaim goes away,
> root reclaim would mix a live node counter with a stale rstat value.
> Unless I'm mistaken it should go here as well.

I think your analysis is right. I'll add NR_VMSCAN_WRITE to the allow
list as well.

Sashiko pointed out that NR_SWAPCACHE and the other charged-folio
stats between WORKINGSET_RESTORE_FILE and
PGPROMOTE_SUCCESS in memcg_node_stat_items[] also should be added as
well. I need to look into this more.

I'm out on PTO for three weeks but when I come back, I'll update this
series and submit v4.

Thanks,
Joanne
