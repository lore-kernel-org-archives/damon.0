Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662176;
	b=2tUjZ2Hot4rQC85Ucrh67rGKrMHZORYZCNepcqlrNKVsqOIH+/hf/uODarM2ftuuxP4p
	 kp5nLeqSG6BDlpDXzxvvWPoas/Pl7wBaP7s6xasU7+hwUKnUjhqXElbvnF9W/trY9H424
	 ET6FMK1LO9xnTyKTwy7CO9OkoT21gIXbTUH2FqxdY6AzvXrJKxI2jPWP7g1H48W4dqsqJ
	 KEd/+3r3KvQmjyDCpCqr+Oa1wVJggTpChb3lSGRLfgXMoaynRhixw83BZ7YJWPHtQf3Lh
	 UxLc05nPXbPM/NeZyk9KMbi6CzqqiE06eDiXy0xTjR4h7iNTa7EdBlRJPd6iiRUuWWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662176;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=YTKi2ZfuXtkzbJQerS/R1oO64J2LCdQqFsgYxGf3I7A=;
	b=KP6Bo3GCD5ew2ZwOb6fkFbn67zWQc3yfOXcjAJ+OHzSfWn1v1L9uKASnWsTETAIvOn3e
	 YkwasTRCw7JMkbjN/beQkI1WSJNHTz1UjiI4FnO0XJIJI/b7AXZ3ztEulqMp+yk3pVjeI
	 EUVqUfvaw3J2ocRhttS453h959Mt+32mVWW2df5xq+OAlTaZMnbcCv0Bwq7U2d3igbo3u
	 ss8ic0pIX72XTwS4SvNP6MQERDBkZbLnH9a1ELAGPKhlNK7q/5SIEZ0sgczXiuX2Jdx9z
	 IUrjcosNVAF0HeGWSi1IQ0c4aHsXk8bGLFVOzL2Qvs9ZAohWJAPZMYz0pZsLfWhqz7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLmxYpKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646BA606A326
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLmxYpKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207981F00A1F
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 23:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793662175;
	bh=YTKi2ZfuXtkzbJQerS/R1oO64J2LCdQqFsgYxGf3I7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iLmxYpKBtb2Sdv0r01qtXOVlpvgwAWru+Ok8vsOsBX4TUWT/L3zIPpIEZIEWF7vdx
	 t8NntwM9tD/+nK96mxlr/NPIwELo4bF3H2n8XE4d7C30PFnO7jgAaL3NP9oyq9X9S2
	 jt9BkWKOGgp4pkADIcBhBIQoH+shB2mgdM/3dG8K+bbkCvX7qXWQRS1cPGnpTaW9S1
	 C61TAVnooyiRHepDeFGV5dEKolSdlaasXHuN2HJgLpJ9+EhlSck7XqnFX9DcGYVTpp
	 yLdxyMXJ8SIqh9bdjs2XFDFX6j07xSXenmV6L/tkuUrInI1EigN+A9+RaXbiuTHgg7
	 E2GiFdzlDl74g==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4322d310e7so581772466b.0
        for <damon@lists.linux.dev>; Mon, 02 Nov 2026 15:29:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxpNg1t1itq7DwP9lq7JZZj5x4TmKRTC0H9YRecD5kR0WOhUCPsDE+u0fk4dPj4cvFUQBQkqw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+6BYFoDiDzYgV+4Hr4U5QJF6lU3FJ7uCp4GnCLRaa1c2A+sSzM
	SZiJ4RUQPrhCvKDpWEaJeH1GNpIo44C1FSJ4SBls+Xh2xlL242qP0x3MASN/rs36oNjXvHM0+vJ
	RUDS6yllSDE6G3EPXtzqxIKnsizIYBZM=
X-Received: by 2002:a17:907:6ea6:b0:c2e:378c:8ce3 with SMTP id
 a640c23a62f3a-c4ca7aa72b9mr897146466b.32.1793662173962; Mon, 02 Nov 2026
 15:29:33 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261102225030.2743129-1-joannelkoong@gmail.com> <20261102225030.2743129-3-joannelkoong@gmail.com>
In-Reply-To: <20261102225030.2743129-3-joannelkoong@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 2 Nov 2026 15:29:22 -0800
X-Gmail-Original-Message-ID: <CAO9r8zP87zRuoFqeKFcAJoCrOG8M+7HCtX6hvxwdLzuHUXD0Gw@mail.gmail.com>
X-Gm-Features: AclHuK-4t4jepCmFSgrDiHYFCB2QMcYxAclyDHxOZQ_Fy5-IrgHz_mEoVtmdPJI
Message-ID: <CAO9r8zP87zRuoFqeKFcAJoCrOG8M+7HCtX6hvxwdLzuHUXD0Gw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: memcg: read root lruvec LRU stats from the
 node counters
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, david@kernel.org, 
	ljs@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ac6c43ea8c5a..938843346571 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -587,6 +587,50 @@ unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
>         return x;
>  }
>
> +static bool lruvec_is_root(const struct lruvec *lruvec)
> +{
> +       return !mem_cgroup_disabled() && mem_cgroup_is_root(lruvec_memcg(lruvec));
> +}
> +
> +/**
> + * lruvec_lru_page_state - read an LRU stat of an lruvec
> + * @lruvec: the LRU vector to read from
> + * @idx: the node_stat_item to read
> + *
> + * Like lruvec_page_state(), but for the root memcg the node counter is read
> + * instead. For stats that only track memory charged to a memcg (LRU sizes,
> + * workingset, rotation and reclaim writeback counts), the root memcg's
> + * hierarchical value equals the node counter. The root memcg can just read the
> + * node counter directly instead of going through rstat, which requires
> + * flushing. Flushing the root memcg flushes every cgroup in the system.
> + *
> + * Use lruvec_page_state() for other stats (eg slab).
> + */
> +unsigned long lruvec_lru_page_state(const struct lruvec *lruvec,
> +                                   enum node_stat_item idx)
> +{
> +       if (lruvec_is_root(lruvec))
> +               return node_page_state(lruvec_pgdat(lruvec), idx);
> +
> +       return lruvec_page_state(lruvec, idx);
> +}
> +
> +/**
> + * lruvec_lru_page_state_monotonic - lruvec_lru_page_state() for delta sampling
> + * @lruvec: the LRU vector to read from
> + * @idx: the node_stat_item to read
> + *
> + * See lruvec_page_state_monotonic() and lruvec_lru_page_state().
> + */
> +unsigned long lruvec_lru_page_state_monotonic(const struct lruvec *lruvec,
> +                                             enum node_stat_item idx)
> +{
> +       if (lruvec_is_root(lruvec))
> +               return node_page_state_monotonic(lruvec_pgdat(lruvec), idx);
> +
> +       return lruvec_page_state_monotonic(lruvec, idx);
> +}

Why not do this directly in lruvec_page_state() and
lruvec_page_state_monotonic()? They already fallback to node stats if
memcg is disabled, why not do the same for the root? Are there cases
where the node stats are not the right thing to do?
