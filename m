Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705312;
	b=2xPtymDC1A8bWRnk+CurVGLRhBRDDzfCB/UOLDxKZ/3aULf0Izc53ycKEcNp62G67tnj
	 vOzi6fU+jhOWD4iqn5PuUOqN9vRdjvGHMKHee3eYj3YrgXvjtSzuaK25BwNvkYnXc67pS
	 Xw9Qh/yO8Pnn227GjWmoHyu1eLuIAFyUTn+ZGqWEFjV/kYV9vj49ZnQYw7qV4LOMgiR/w
	 BjEn/D6cS6MLRcdJE3VM4sDHKcH1untHKCh6GaRLxuGN0OHGHD39Wtp9vIzIF6jTruatX
	 jmduSoD9mYY5RtwhUH0ltN8Sw5vJ8FV0miIeK6v+nYQd/LDx/FPdAvypNBGO14pURrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CnA3zlb6+Q4MfV6Y5oL8cXYKHj+wdTkqxg32r451qEk=;
	b=xAJ8629OFnFWm+kubO27HxSplwiA5Q4+UfTYTJ3401Jbi72/Ix9AcKYCve891wToMy5J
	 65cuav4GUGIbmed4yexdWIw0XMrk9i6QLi2sRw1VeR+LivbBaZPcR3fOnrS0ROx9qUBxd
	 Eg8ZxJdeUVl5yDm07MMzrLLyl7LdUEHECcTu2zkqEY+HE25ZQhWMtsPiG7u8xdViym6wc
	 iwZa6xw3iiViy1YOOP2Bu/3jpKO8wxxMEt/7IL1ycbMkEsb2zMdmKFKfBjEckNCue088Q
	 6oJdwO2mutAwGyWr3MG+t0DLum7q0xB2fe5fhN7zKSMQIcsvBlYhJT9oZtRHznB5wtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzGgLirU;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A39606A680
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 15:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A39606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzGgLirU
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f02f04a426so57690225ad.1
        for <damon@lists.linux.dev>; Thu, 26 Nov 2026 07:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795705311; x=1796310111; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CnA3zlb6+Q4MfV6Y5oL8cXYKHj+wdTkqxg32r451qEk=;
        b=SzGgLirUV8fuCc8phHwMC0HGqedH5Jaimm5ElyvKEC5ycd37r9WthLxwC3lKvi/r34
         oeHoOBFkyuHQiLhwGraervIQ1pNpa1hL498jJWzcYiKiiR5CJaEl6DDgclo5ptTw70zu
         v2JTS4MX/vKJyzUtwrvLNfq7N0gCWd0ZsdOO4QMWhknT0fcMd5dawPe48BieH5k5r9uU
         zpWyRYjKHbLuVP/Jy4JijxAoM8Ytxs1Ln+xowoUTUMCya4GzBH/3IrQSh38Ts05W1WSc
         78gR+BZtmHgpbBxC6t/aO+OlTDJlBweCOH9D3jHgZLopywg0IoKIgClEQmEcwrKb8KD+
         Zi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705311; x=1796310111;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnA3zlb6+Q4MfV6Y5oL8cXYKHj+wdTkqxg32r451qEk=;
        b=DoMxfkoduV25mfANeTJ4MEByb+MxFwNoQlvweXj1qSVLW7bN0zwXLfzNWLw3ubHSiz
         AeBA0TfuXBM+4r+O7IcX/oXAgJQi5SzPCTqPM6tBbbf1jVw3MKS+GQ3whN/hFY2AxuNl
         YlwiQJEuxP+VcIk3/lmBp3Kfp5mkxy9eiymy+hFpgxb0s6ef/LXVA6d6kk8OuigDKDC/
         tNQ4bNSblfGBLKeLbqhDmqK2+qdQ9/ShwnqPhXcjHGMmIeXs8mFq4RA88N7rEXt4VXo5
         CdPbPubI4cQsmlvfPQSLC55F2oHwgUoSuzEy9/F2OBbyIfwIcZ3NlHNCac5ibv1UkL3m
         nkBw==
X-Forwarded-Encrypted: i=1; AL+hErHRUfWQaFPIxLIsNgYGNzKDmduFNt6bN1Han2l67QCYtxJOjR59oiFzrRf1fW2/L7omqgfbfw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+bZSSFPN9eUxIOEcR/mpYZRSg38BeHBdFEgU6jG679w4QoQngm
	E8gO7CZmEPgNUIvwnb5ntmcy/zfZK6krglwcYkEVk2gT5Kwf+aMDhZJA
X-Gm-Gg: AZFdTZcSeqd3hrbhhLfMbZ4Sif3Ej5b2WO1WzVB+O9FP/cufgdtlnwkng52PtdVQY3d
	oq48pQuKnrev9LBABnMilgllQE6pGE+4OcUm3UwBnWiVCWmezIeiFxdgytoku1dkA8Kv0WBD5W2
	RY9wtv8D1Aluu6tKsapDX0JagYJLzrRC4Fqa7gxQ0Dkl0ClUfnrZAhQ9fZI7tAHIZ4QYiaPveym
	O0mzkxeuIhKDIM38VL2ocp0Ua50HfnvDnSHT5396HmAaqu7qglde8MwlJjwz1PgDnL2v+s9c3vp
	BOyNTaI2WultJhn12saF0BVfNr8NA7ePxmwstAmfw8RQAa79HoJtqyRvQN1OrLFTLXWE+ycKk5o
	aTwmpvLcFukBM2TvPEbxwKnQegM1Jd1Tcjs8nfF/LiJIIbFazDbdTd38Xd3VuKHCspDcRTG90DM
	CmmYIojDk50JF1Ie38nlUWEVocLVSienzeYwSllYqGZwwtMjVUtuTZSkAljzD07l5+VGY5HWd7J
	jUs1u1thnh8DX+a/2ydUolDHof713JHX2QBTnnHS2SmevOVaEJ/WbgKSEiNSt5U8oX7fgbjuYxb
	iYQzV2ApA9Oxpm1jBKeKkJzm+239E3T8cRAbCyVvRwt6
X-Received: by 2002:a17:902:ec8a:b0:2ef:e25e:e13c with SMTP id d9443c01a7336-2f03efb015amr233195175ad.5.1795705310670;
        Thu, 26 Nov 2026 07:01:50 -0800 (PST)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f15663fsm103299005ad.76.2026.11.26.07.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:01:50 -0800 (PST)
Date: Thu, 26 Nov 2026 23:01:33 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
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
Message-ID: <c37b9336-95ac-4787-8a7c-73f6ee9d17c2@gmail.com>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-10-8ffea39934a6@tencent.com>
 <6c3d32a9-3004-4a17-b854-7088e69f164a@gmail.com>
 <awfb-vGF62XvcX_F@KASONG-MC4>
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
In-Reply-To: <awfb-vGF62XvcX_F@KASONG-MC4>

On Thu, Nov 26, 2026 at 03:16:32PM +0800, Kairui Song wrote:
> On Wed, Nov 25, 2026 at 09:47:18PM +0800, Vernon Yang wrote:
> > On Tue, Nov 24, 2026 at 02:53:02AM +0800, Kairui Song via B4 Relay wrote:
> > > +/**
> > > + * folio_inc_lru_refs_fast - Bump folio refs count without promotion.
> > > + * @folio: the folio
> > > + *
> > > + * Raise refs from 0 to LRU_REFS_REFERENCED and leave hotter folios
> > > + * untouched. For a folio off the gen lists with MGLRU off, a plain
> > > + * PG_referenced set.
> > > + */
> > > +static __always_inline void folio_inc_lru_refs_fast(struct folio *folio)
> > > +{
> > > +	unsigned long new_flags, old_flags = READ_ONCE(*folio_flags(folio, 0));
> > > +	unsigned int refs;
> > > +
> > > +	do {
> > > +		refs = lru_get_refs_flags(old_flags);
> > > +		if (lru_get_gen_flags(old_flags) < 0 && !lru_gen_enabled()) {
> > > +			/* For CLRU, just do folio_set_referenced() */
> > > +			if (refs & LRU_REFS_REFERENCED)
> > > +				break;
> > > +			refs |= LRU_REFS_REFERENCED;
> > > +		} else {
> > > +			if (refs)
> > > +				break;
> > > +			refs = LRU_REFS_REFERENCED;
> > > +		}
> > > +		new_flags = old_flags;
> > > +		lru_set_refs_flags(&new_flags, refs);
> > > +	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
> > > +}
> >
> > The implementation code of this function looks a bit convoluted.
> > Would it be better to simplify it into the following code?
> >
> > 	do {
> > 		bool clru = !lru_gen_enabled() && lru_get_gen_flags(old_flags) < 0;
> >
> > 		refs = lru_get_refs_flags(old_flags);
> > 		if (clru ? (refs & LRU_REFS_REFERENCED) : refs)
> > 			break;
> > 		new_flags = old_flags;
> > 		lru_set_refs_flags(&new_flags, refs | LRU_REFS_REFERENCED);
> > 	} while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flags));
>
> Hello Vernon,
>
> That's very good suggestion!
>
> Only one thing here is that
> `!lru_gen_enabled() && lru_get_gen_flags(old_flags) < 0` doesn't mean
> it's classical LRU, maybe it's just isolated. How about bool on_gen?
> Or bool has_gen?
>

Thank you for your explanation!

For has_gen, looks to me good.

For on_gen, it could be misunderstood as "whether MGLRU is enabled".
So I prefer has_gen personally.

--
Cheers,
Vernon
