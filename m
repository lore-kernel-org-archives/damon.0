Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EE3537F8
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727810; cv=none; b=T13SyCsjtO8ZOl4NiTtLwv3KEmManvt6Wox4JYQ+cPaDwjoyWphjx0NwOKRQR6iqBvlFIO8d1TJPK6Pn8HjNiOG5WeRcKceSELM8RrEjKi3SYOppaBjSuPwew1DKl2DzwirqgOvayutJyOMu1YcDmHlsBJ6kZjEE8T2kGwBQF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727810; c=relaxed/simple;
	bh=PYGMpBdbfrddSWhi8wSkhjZKYMi0cam4nIYPZarnXJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/mt91xJ6RKKcn2jcHSbzD8D4uszSWI7/4jDFK5V/mvpSJKbIYXd/fimCJbgPq1yXRdxcaLy7gRPzurmldBjQS+PyyiMT9JBlqjma2DkOW+bsrcLaH5L86nq8O1eLZTLH/KMtvB1oSaPHKg0uszu2GC6dXakF+sSp57RRLQ/W7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=H/Lvk6t4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="H/Lvk6t4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51bfbe05683so114951251cf.2
        for <damon@lists.linux.dev>; Wed, 22 Jul 2026 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784727807; x=1785332607; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqGzltcyJPxwfdEhPSjMSETzXly+gOy2t1lReGVE8tY=;
        b=H/Lvk6t4lw8KpunkV//mmpzqtWvnwsfcMiR9sdvpjOxGa3Z0A7F5VXT4QaN1bNobZl
         YYVMnX7bkD989RhWG2O2qlohZDDsycVNat6cJkCRUAdUfod/fTQx5uNUQuPa4gkD6v+D
         SzUuQbHwi+vKogycXLQLKaNQR+c+PdJiaReJMl9537XDZZsrlAM6y4l4A50CGnRuYY71
         IWIqI47OYPDdSmZhFxAbukXpAkaum1xIQc5Gvnd5U8tnD/2V3iyUdLaQA0EpG2G8n07F
         ftPrQ4GRC79/BXG9vFViT00iLqX26VJnIW1mrCxsTvlSz7oFHy6GQghCi+Ssp+lkRoBX
         AsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727807; x=1785332607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqGzltcyJPxwfdEhPSjMSETzXly+gOy2t1lReGVE8tY=;
        b=Xu8ShDZz2b08V3qRhO1L0+gWgZPGWWY+zxcSeLeLlDwfnOqgaMgDS8h0xTALGfK0Ii
         1aGc+EVO5HhQmnYTka9fILLtscV2Jhw+Xtyv06lSlNtanR9IIyAQ8ngpTGvivS5lay3Z
         klcj3tLZ5MaVI0QO6cwelcEAt8d8jfvf8GkPLEPVLIp8kIhZyrduXa7tMIJ55Kxp3kX3
         135cbfuVBcL/THBQfLcjaxWmg/sbT2rQT7F8FsWz58t5Q6rL6QvhvsJmn4g8W+dfLCWm
         JnUEyie8nOHFFQigUXDLMGC6PZWApkANGiRChbz3rSSHCSM1pzQ6CT5s45ZFToamC8hV
         wSEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTxCAhRn7iyP3uzxt0tObzi8GHcASIJ1g8c0q4nYtLXRFZnJJsLjZ0UlC5cq8hKbbL8s24jg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0LCqWByi7KwMdiqT7BDpar57s/z4hIqQuex/5SHHAygPw/SBb
	1nmDTQUiU08T3UELuqkhQShc3OO3M3VCnlktDCqUXqHbcVnX7Yz8242G60HzYz6g720=
X-Gm-Gg: AR+sD13u16dzFCwlQC4Sw1krb+b146tJvLmMaMEJB8T8EInu98rJvf5FQBIYc09+xad
	YkmnTy8/kPO5l2uFInyTq5/vJkIk5nDFsNRIa4KMlYl98Eqbe7wwYwdz6grKHrbexgUDylkFaEP
	yVbEhSzd434vA4/xhbCZz0EeHxjgbpNHWxkl1Uzmx/frjn7gViTOwdBlYw0m/assVRfsGqiXbzh
	4nX9tV+bI+BoHw6Z/jVkMr5NMXxnhlTXr4Vu45yRuMXS7Ym9O4TM+xQKErsiaVprI2nlF4+3tLj
	/oQY7+H171LIYYAmaEd8QJ43zkRm98KihML5nn6/fQSJiqpWHZ29HX8zji3pF72m+JgHR//R9vT
	2zt2LYsQTbXQJi3TOZ8ZcsL1QS6AfWXIkQKvXyVIsenxm0AlC7Fcg25niGEKIgXLkPMJTWPMA3z
	Lgz4GkMiWe0TeC8RXPQnQWUmY2fz3TFO4Xs3vhqRl/fr1vjT2ZxSCuyKONsACPpVG+innY
X-Received: by 2002:a05:622a:1f91:b0:516:e152:7a59 with SMTP id d75a77b69052e-5213e08256bmr218014961cf.42.1784727806950;
        Wed, 22 Jul 2026 06:43:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3b3f66dsm15332181cf.27.2026.07.22.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:43:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:43:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 32/36] mm/khugepaged: base private node collapse
 eligiblity on actor/cap bits
Message-ID: <amDIuZSsOPjRkywY@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-33-gourry@gourry.net>
 <amDEEnTv0QumcDJn@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDEEnTv0QumcDJn@MWDK4CY14F>

On Wed, Jul 22, 2026 at 09:24:37PM +0800, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 03:34:26PM +0800, Gregory Price wrote:
> >  
> >  		page = vm_normal_page(vma, addr, pteval);
> > -		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
> > +		if (unlikely(!page) ||
> > +		    unlikely(!page_allows_collapse(page, cc->is_khugepaged))) {
> 
> I think collapse_scan_file() need something like folio_allows_collapse() check as well.
> 

I believe you are correct, sashiko up some stuff here too.

Thanks!
~Gregory
