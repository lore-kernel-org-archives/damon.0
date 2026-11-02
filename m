Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661918;
	b=N38195LXLthJHrSR+sAK6TSCE+jiKyzQM8nNzbGnvFem0iEgjcU/xXGJjeglvkgATEvd
	 2OH8AsiycJ08RiI01kgvWfk22yehc+e/0Na5272/SMxg16oWowF/PVY3omFjil2dO9zvH
	 h0ad9AqLF98bLjUO8HX81g9buvUiwT80r+gqfenk4dO2lKk52K1Izvz94CZQeTjdWvZDn
	 xhgFYxaIJTEZ8DeivwPjJchGPqmidRsMRzyEuT8L4RlETW7zj1I9kwP2av0OZ7rSgXbXX
	 zv5ncEqglM/iVS7mtYfa6vDbzJInqjUbEwCY6opD2L3TD24Lg8KOvXkLEFwFWuyFsRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661918;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Vb7HtkX73433xtUzqqWbVnSmEduHdD/Vc57qkP1iLvg=;
	b=nVc9hbE0NP073v25bvvWHwdZxMMuWB2BexTzV3T98Bxv0NkTD/bKduekoPladQF/E4sO
	 VYCDXVNRG6F8usjrYONB5xN+mNHMH5orwzPsqqNJH1mazW4rojJVKRhC2+Km4hAqRzoE6
	 OnxdFnCx5593UKa8V/Au7r2XDLhJ+Vfcayi+jXJXDJsyF8spbfRQ4bvxpOcsyZ+jtfr/y
	 LH88hutf6gLXMaNovFCeeenwJgP7uw70X3LJTt3CE2sIDEP4ltV6M8MZgajhs5bXsC7tC
	 0O6uqVK2eyUEAV5jDSGWcLLiH63U8e+rIqkf3Hoj2KNYDOo6ix1xTyaTDjWk475z2Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBqmeNNG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995E606A327
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBqmeNNG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F241F00A1F
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 23:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793661917;
	bh=Vb7HtkX73433xtUzqqWbVnSmEduHdD/Vc57qkP1iLvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OBqmeNNGZHL9b/mqGT1ya+9SGOyrRQ09iqF5W2E1MpvLqbSpIQR8EhDzW5Ds0pK1Q
	 vuAxA0bBJNQGh2L2D6+8j+wof5F99cRXEqAdgdIf8jyUKWf2WaazyXEjw1+GeUc9pM
	 nHaVAA+pD/4iKZGDL0AUumdU+14WgSAhBzKXq35iFOJE3ZsfsD/APTIJIcc6Km0ryq
	 sR3tiFP7u0HAfb87ycF2cPsiFGQJUq6PLsN9Ec88PUqRSVlgNPEDLYjQsuyt7o1YnO
	 I+6ABrf4/xwSI8OtidDsBoSkm0MUZs7CU0a5NqBHkOfBXlSVISIQnWlwahkQ1emod4
	 un8Hizug9xLEA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso435577266b.3
        for <damon@lists.linux.dev>; Mon, 02 Nov 2026 15:25:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwUtVhHwVAkvOXcU5NjSVafcAFcpNMjPWLVQX+sHKNYhgdTPHv38yo8BVHsQnreW2hdAXRBEA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/YlnvwVnawx0KzTywbOOsLiAZ1VcqpUMeuhZDH01GY0lmtZa7n
	r8QuLKj9+Dg9QPIxCNaCiJnJDV9ERCxCjexX+Q+g3O70jHSnc95gosOVK8/is+nD0VCxFo1jzkt
	1W1i70v6vq9Zxz24EmurnvSPAR5gYgoU=
X-Received: by 2002:a17:907:5c5:b0:c3f:8c92:3b5a with SMTP id
 a640c23a62f3a-c4ca7a41ac2mr936046766b.12.1793661916543; Mon, 02 Nov 2026
 15:25:16 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261102225030.2743129-1-joannelkoong@gmail.com> <20261102225030.2743129-2-joannelkoong@gmail.com>
In-Reply-To: <20261102225030.2743129-2-joannelkoong@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 2 Nov 2026 15:25:05 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMWOda=j=Y0hdg32myOxQvE9MKLqFq_zNg3RMn=XJwALQ@mail.gmail.com>
X-Gm-Features: AclHuK-Ty7Urj65mhCgz7LxhIJtH9a0TCSeDIGE09_PbY5bWsOV6yqbGX4M-Ndk
Message-ID: <CAO9r8zMWOda=j=Y0hdg32myOxQvE9MKLqFq_zNg3RMn=XJwALQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix shrinker count for the root memcg
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, david@kernel.org, 
	ljs@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:51=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> zswap_shrinker_count() scales the number of freeable entries on a
> memcg's zswap LRU by the memcg's compression ratio. That compression
> ratio is computed from the memcg's MEMCG_ZSWAP_B and MEMCG_ZSWAPPED
> stats.
>
> However, for the root memcg, the zswap entries owned by the root memcg
> itself are never accounted for in the stats (obj_cgroup_charge_zswap()
> skips the root objcg, and before the root memcg had an objcg, its
> entries weren't charged at all). The stats only reflect the entries
> owned by the root memcg's descendants. When the root memcg's descendants
> have no zswap entries (eg when the whole workload runs in the root
> cgroup), the shrinker reports nothing to reclaim for the root memcg, and
> its zswap entries are never written back by the shrinker. When its
> descendants do have entries, the root memcg's entries are scaled by the
> descendants' compression ratio instead of a ratio that includes them.
>
> Fix this by using the zswap pool-wide counters for the root memcg
> instead. The zswap pool-wide counters cover every zswap entry, including
> those owned by the root memcg.
>
> This also gets rid of having to flush the root memcg's stats, which
> flushes every cgroup in the system.

I would have taken the patch just for the dropped flush ;)

>
> In a VM running a reclaim-heavy workload in the root cgroup with the
> zswap shrinker enabled, the shrinker wrote back no pages before this
> change (zswpwb stayed at 0) and 1016 pages with it.
>
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: Yosry Ahmed <yosry@kernel.org>

Thanks!
