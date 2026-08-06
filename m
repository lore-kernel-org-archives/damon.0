Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DA3195FD
	for <damon@lists.linux.dev>; Thu,  6 Aug 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036158; cv=none; b=RDAThH/1UgMkj5N9qruVuSjFKSDrjBhNfmO+jDE9mKCxkrpzGo5C+wFnIe8WpcsCvkrTaL1M9qsLHXy6MymSOSD17I9bOJSLXLe0BG9BRr+nmYlJvtfD3NK+5DDVdEjJlyXkk0dtLqBbn/wGmq+CmJUhRBu6g9N4aOvuGFM18eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036158; c=relaxed/simple;
	bh=EwJlQhSQMk4+H4UB1KrYYY0nmJriPg4JWMQ7dVhbqPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caKbQt7NFTS5MgpC+nH55irK6gxLH4ZruTiAdq9Fj8yOUGUna8NPlgwvNCroBCDnqzoFC+0O2a/PI6gGx45iJ1ACEUK38oB5ATV0ogY+n5Jhs7zXV+9eK1/1n7z/Flkoklg7/l9D9Ya0WMO5Pzl9DfxC+YKHKHRHADfqDDpZqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UGjJRrKj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UGjJRrKj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2867531a91.2
        for <damon@lists.linux.dev>; Thu, 06 Aug 2026 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786036157; x=1786640957; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrNvbsHqFNUR3TBZVVh5jck8vhH3UNtuIjBL6oQXZGU=;
        b=UGjJRrKjyLS0dXu5GxVyNBXKqrq6brESCozPg6z1P4kH7azbrQ9disjiPy5iz1tYmU
         seqqgyycT/UKKBR0IuXFsDYhZ8dZd/cKqjIlT8SnuV3QFfgOhbAdBmY9ZeaysOJoTsHu
         6+MF8c0epoxWZF00zPBz6RXesev7diDT1Su9h7/3Oq9MWf0RkuTJT4KSgcuqYmNHVK27
         A33n3r5rtAETETbi3S/Fxgm34fBK6pv/VM6jUyhNgfLCL8SClOG2iKX9AOPzb8Ib5CnW
         28viZw2yOkLMo8z94Kj0bsjR89xnu6wIxbhx1UUhaClPp0jNqTgXaFJaFctVef/al586
         4F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036157; x=1786640957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrNvbsHqFNUR3TBZVVh5jck8vhH3UNtuIjBL6oQXZGU=;
        b=Kj0U3pJRiNqbeSvitC+fRhRs+tYAWVcd5rwf37qIihNGBeMGSNpvAfE++fYsD+j4NC
         xrjA6uSRRaucLVFwJ08rGt1/9TGcocQ2UrAzNfXBpQ0HfwRYJuPDoO59nJAWhKXctUSV
         advoJwiPhiAVNwpIslKZKQSRs7GhDMUC4uwJv8SnszkEmoZmqkE6cDijhC79oxAkIRPd
         5xm76j20rHyEjje/8+9OtWgHf6qeFHJJ0blTsOyw/jcH/uNSFpntmPWQVUsKaXhQE8vf
         Ajz3m7rB7c7xZDYpieQJf4zMR2ZpBdUdPwvhEuN9AeCSjEe/l4Inw4hLQhc5HyaQQwf0
         ZT+A==
X-Forwarded-Encrypted: i=1; AHgh+Ror8hg6zvwtNspDjqBgw4GtsgcOiQMwCAgstd7tvDs9JNlBcyjQZ64g4a1aN8WYycwHwAgMuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwjFpOF0tmpOiCyjNSiWvbb3CGKA2+qbiEWpomBCZ0o5/74+S/
	DKm/xdYBleMbmbsU7dWkzfOWGmpvqSTpnlX+LwU9MURKPRjONS2wdB5YxU6V2VN1XKw=
X-Gm-Gg: AR+sD11n3ROvcxZjIFSjgOy1jMeNYg097GdyB4JFq6ShByAhbTNFB//AROBkb81i9MO
	ReoX7gGkGT1LgxT1vpwh+Bxl3nBWB/7UBYHhmB6+Ma56l7Y7YUs44ufXoW9GwSL61ZD64tzzaIi
	+Xt8WP83Oo/AA5rSaObMgbYULBBekledYJUOswQ97Y6p9c/ZxgpUxvHvACNwfl3oX6b7jso4q3k
	pxSSed8WigN9wn/xJzHhp1tHiLuChvkdqxe7V8CA9YgWR+LXQ7D3TyKcsVR269JEUsk5rZItube
	/Ft7+Hh4G/bpToA1hH82bT0xHfnzOOw00Xcfeybh9pzClm0eb2FoAC3eEHOVrcNBySMG8N1Qe0d
	/1Vx3+RLmddOn2LixOpspq5qbD2LdLRa2DxBgy7vPbaPHCt86onRiq35W06GQ//b67p3/6Qveok
	TDl8lVQLWiqqk+o8LTtqKjXeszzauvXmbVD4Ho5Dlr9a8+Bl/F9DPpiQ==
X-Received: by 2002:a17:90b:4c86:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-3903c5590dfmr14716699a91.4.1786036156912;
        Thu, 06 Aug 2026 10:09:16 -0700 (PDT)
Received: from fedora ([2607:fb91:201f:cebc:3a68:390a:144e:1b87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-140f744adb2sm13381819c88.2.2026.08.06.10.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:09:16 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:09:12 -0500
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org,
	damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sj@kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev,
	vbabka@kernel.org, jannh@google.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com
Subject: Re: [PATCH 4/4] mm/mempolicy: skip zone device folios when queueing
 folios
Message-ID: <anS_uO-ngBV52d5Z@fedora>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-5-gourry@gourry.net>
 <82f6afba-756c-4ffd-bd5d-c3432179af28@kernel.org>
 <anSNk7zgoGj62CWk@lucifer>
 <0c90b9ae-48ac-407f-9d73-4c501c82cf40@kernel.org>
 <anSXFHZZPUf1iFSm@lucifer>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anSXFHZZPUf1iFSm@lucifer>

On Thu, Aug 06, 2026 at 03:16:03PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Aug 06, 2026 at 04:11:21PM +0200, David Hildenbrand (Arm) wrote:
> > On 8/6/26 15:36, Lorenzo Stoakes (ARM) wrote:
> > > On Thu, Aug 06, 2026 at 03:25:50PM +0200, David Hildenbrand (Arm) wrote:
> > >> On 7/28/26 21:47, Gregory Price wrote:
> > >>>  mm/mempolicy.c | 4 ++++
> > >>> @@ -797,6 +799,8 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
> > >>>  	folio = pfn_folio(pte_pfn(ptep));
> > >>>  	if (!queue_folio_required(folio, qp))
> > >>>  		goto unlock;
> > >>> +	if (folio_is_zone_device(folio))
> > >>> +		goto unlock;
> > >>
> > >> Leave the hugetlb part alone. hugetlb folios will never be ZONE_DEVICE.
> > >
> > > <Insert leave Britney alone meme here> :P
> > >
> > > But dear God we have got to find ways to stop hugetlb being this big stupid
> > > nightmare that every single path of mm has to put an asterix next to itself
> > > about!
> >
> > Yeah, possibly unifying the code (possibly, because it's a mess) but not
> > replicating checks that don't make any sense for hugetlb.
> 
> Yup agreed.
>

No disagreement here.  I'll drop this.

~Geregory
