Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677406;
	b=o9NSWF2GUINeGoZ4GfHwPJvlev0Omk5ALG7SmD7O1ZpdVsacfLV4+8BXk97Db/f259ab
	 /icdpAk+RpHGMVY1f5wDcH07p0uZkvhtceId7hdzkoAp+g2aWHJIztkZT5g/r6eiDnX3R
	 /Gzm1t3VmQC8C7YFqyKHagouSvO/nt2cwlOQt62aG6plVpzB7vopVp0jY3DBKTLzLEqMn
	 CWcUx6xzCQO0G7qOeUNUfYTR7nLoKJJmVu56uNLl3rdef0D/vUsDQ5TZ6HOyYwFqiwI9f
	 N/YS9C2wgtv30ZiizfssKHf35m+XqKirwxVZbT8BoZVXv/cziyUFHlhchRUoa13je+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tioXBSwm5pktLh4V7ZjeytUoL0urdjzGdHunvMaRHSk=;
	b=w3g5wWdcuI1jy4MNG5YaChllfu1s4dRt1QkVeZa6MMMKea0RW92NX1XoFaTzI123bZHm
	 VRonSrQYNe/ESemvvU9XCghdYG72PeNwRkBXefbmrpJ36RQ+koBbVh2hhrkD0njG50j18
	 8unLv1VisuLnF315UCUGdJua1h2xXNXT+A4oSrgZVU+cMAnxFsBuZqAhg7pSd7I4qMSLa
	 FcSlvqNJiUvQNcrNN1WIfD5aA89px1fvGgKmaNslDXjBH+CAwhLlcQvQ+ia7VoJwYESQZ
	 tTzocfBhh6EX9gTlZ/n9Uqe++aIOMnJS+UCpqD5sS0noiNdFHLnTZfAROGJ7KCtJp3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xiyTaDDW;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF9606A32A
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 07:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79AF9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xiyTaDDW
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso4533046a12.2
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 23:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795677406; x=1796282206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tioXBSwm5pktLh4V7ZjeytUoL0urdjzGdHunvMaRHSk=;
        b=xiyTaDDWqRnooHwOZKEDHAn7dWQ57jnCUeinwpTMzVfMDEdCltKicoZfLZ9DzS6z/L
         k8jo1eMFuT1yiVtBpCuEjYlxAFsKR/H7pgZra2s3rQhAex8MyCj/S0EinPpsOhTSAF18
         YHuAPQ8cTxIOidLWxxetl1cKsw5ZJ4vSRe+JokIGRsudWlTx2gx69I8NlCZGGKZZlnCg
         cbwivQffA9ZEJ7GkxEqYoyCkUOleDWWi+1VEV0IJVi2c7cHS3llf/iLZhIFgC1WOrw8E
         gimQtwbeVbauZ4VOLF6Zwzf86fKZs57EBOQjaGJI/BDSIAYo7rTblGRPRd20drw7jR2r
         1oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795677406; x=1796282206;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tioXBSwm5pktLh4V7ZjeytUoL0urdjzGdHunvMaRHSk=;
        b=xWYJKum41scuj6nhvlqhh2rbr//iWHnffM500aFY5uN4rzkYUwdVRPvMMgdMH/6PR1
         QCZ7JPT6uXOTGpH2aab14Yg+oOUN9yVafssEEqVrEsuu2pQX9VTzUShK5i3I+fKoT7sT
         waA337bzB2q/8Kw/tRDNnhd1bDtDRwI3wpJNNDh1udr3LQKMCxEIh4Lcnued0EP+Qiel
         s1rPJSI2dUBRHmUbvyjuLe9r5twf1cm+Fqm6XDFdE/CvT8xNJWkQke67NcHF0ssoVzCY
         TIBPUBxzNx6Lf0xJoHW7vzn/3aUZd7pmHPXGe3UrDJ4as7P7zMj4I5PB2D1MZngK95Tq
         h88w==
X-Forwarded-Encrypted: i=1; AL+hErExCKujo9b/V3Zzu7HBL+87VY4AUJElRN/pwnLPQV8s86Gpne9NvuPRtULalJBnJzgvndZ80A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Z91s8Wb20J82U54FrUA1WkkENst5KA83vIxn9B9epEWzamdRm
	DDuBtxkm/sb9DsDj7TGFknLPWPHc9gdSaS9gvV+Na1n0Hpf1Mbn9xufK
X-Gm-Gg: AZFdTZeUacMF5HMD701uM5TL7wvsATFziaEd1XIt88K/cV+Exm4l5ecMu+yYXkqnCuD
	YBC5ar6DB9Nio/0OVdy9bNixiaY3BOZdJ86pleWuNSYQQPvKXq0GS7eALVKIQxRfBCDg/lC/hII
	FMGmYPkH6x5MzSSgurq71N0dH/akMeIpfaHGjRTZhaFX2CulxhmNiRmLeeNpyWoRZOmnFXA7MRP
	MLWDgmLbBPVE4Cq5okfVDVIr87hTF1ZNUbqbpxU8H+2JaT/ffjeUsx48N4ViQFpUnBhAhTVY/dH
	LHu7+FQKN/7tbXwrTaPl6NMA04Gf60VT1rta/YeCNpmDUX+hrBOsFBDU39lpp84x42izHUyzP8L
	vE7Ra/6qiZ8J1geDyz8BMK1AZZw+1hePGrEfOwQTw0fEJCN3hZ6l3jdpWfPb4LHaiOTsGh5cFQ+
	UgJOaKyWQu/gNq6tMbU1hERJ6419c75RNz+31/l3MEr0uCtLYGQCCGoOPerU8KrtE/k+VVJFP6i
	HoMdAIdBiKYq63lP56i3EBZumIgHdbk5OwmiUI4S73EbkZMPoE3dO6TzyLURtZzsXncuJnHdXVa
	mTrbTeFI9vTxqlaht45fZsXrZOXLJWtvRNWa1zaqGPZ/rCU5NiB6dF/EIc0umRSTCPbEVgiq9PI
	=
X-Received: by 2002:a05:6a20:9389:b0:3eb:9e7e:1ebe with SMTP id adf61e73a8af0-4014b65c9ffmr25687016637.21.1795677405734;
        Wed, 25 Nov 2026 23:16:45 -0800 (PST)
Received: from KASONG-MC4 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c86d821637sm10523020b3a.0.2026.11.25.23.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:16:45 -0800 (PST)
Date: Thu, 26 Nov 2026 15:16:32 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
	Yu Zhao <yuzhao@google.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Subject: Re: [PATCH v6 10/18] mm/mglru, gup: mark folios referenced via a
 fast helper
Message-ID: <awfb-vGF62XvcX_F@KASONG-MC4>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-10-8ffea39934a6@tencent.com>
 <6c3d32a9-3004-4a17-b854-7088e69f164a@gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3d32a9-3004-4a17-b854-7088e69f164a@gmail.com>

On Wed, Nov 25, 2026 at 09:47:18PM +0800, Vernon Yang wrote:
> On Tue, Nov 24, 2026 at 02:53:02AM +0800, Kairui Song via B4 Relay wrote:
> > +/**
> > + * folio_inc_lru_refs_fast - Bump folio refs count without promotion.
> > + * @folio: the folio
> > + *
> > + * Raise refs from 0 to LRU_REFS_REFERENCED and leave hotter folios
> > + * untouched. For a folio off the gen lists with MGLRU off, a plain
> > + * PG_referenced set.
> > + */
> > +static __always_inline void folio_inc_lru_refs_fast(struct folio *folio)
> > +{
> > +	unsigned long new_flags, old_flags = READ_ONCE(*folio_flags(folio, 0));
> > +	unsigned int refs;
> > +
> > +	do {
> > +		refs = lru_get_refs_flags(old_flags);
> > +		if (lru_get_gen_flags(old_flags) < 0 && !lru_gen_enabled()) {
> > +			/* For CLRU, just do folio_set_referenced() */
> > +			if (refs & LRU_REFS_REFERENCED)
> > +				break;
> > +			refs |= LRU_REFS_REFERENCED;
> > +		} else {
> > +			if (refs)
> > +				break;
> > +			refs = LRU_REFS_REFERENCED;
> > +		}
> > +		new_flags = old_flags;
> > +		lru_set_refs_flags(&new_flags, refs);
> > +	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
> > +}
> 
> The implementation code of this function looks a bit convoluted.
> Would it be better to simplify it into the following code?
> 
> 	do {
> 		bool clru = !lru_gen_enabled() && lru_get_gen_flags(old_flags) < 0;
> 
> 		refs = lru_get_refs_flags(old_flags);
> 		if (clru ? (refs & LRU_REFS_REFERENCED) : refs)
> 			break;
> 		new_flags = old_flags;
> 		lru_set_refs_flags(&new_flags, refs | LRU_REFS_REFERENCED);
> 	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));

Hello Vernon,

That's very good suggestion!

Only one thing here is that
`!lru_gen_enabled() && lru_get_gen_flags(old_flags) < 0` doesn't mean
it's classical LRU, maybe it's just isolated. How about bool on_gen?
Or bool has_gen?
