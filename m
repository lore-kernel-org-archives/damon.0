Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60C3955FE
	for <damon@lists.linux.dev>; Thu,  6 Aug 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036069; cv=none; b=btVuA0FcYthcb/LghvvPk3doSBMvTnHwOzf+cgGlY0oU/Gn1lICC7ZJXsiMVpaPP8eAZzjklyEEgjp0LCqAtas6P1PgKn3u5hFFatIolOJPBbZwFBbinSbYphrFKJhxg921PY1zzbjn3iydr80v01PS4YHZZtfwZZ0v6qRVN0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036069; c=relaxed/simple;
	bh=y60AIT58W+34jGWPxcsZ4lEyQiqot5BOv+PwxbdR1fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3pRbR0czsL21Fio66BMLPN4Ah/sfF98QpZVNe6ObB+Iz3EJ+gGx3Rh30GgI5tDB131VuVefa6PJCX6RMru7g09gIWHE7tY5M0bbRRbsgxiaAcwa2sPSu0Yf/8475aoIzw+g8W5eI5vNPLy0Nn49v2v3dcjgFIIkAmHGS17tJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T10YVPU7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T10YVPU7"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb85186d43so1366732a12.3
        for <damon@lists.linux.dev>; Thu, 06 Aug 2026 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786036067; x=1786640867; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CpqTarvM3plb3e18QvLpdCn5d0SiQvgtNYeE1iMGePU=;
        b=T10YVPU7ft5hjRJwekHU0rkIpqTHttr9QwXJF1AQqAWDkxrcg5DBW7+UBwvfbeKyxN
         Bz/2chgCaNEDF0kxXGVLYMUYX28GdyZPy4LXskgL/mTcBH7FHZPfI2JhLkJZcX0szuEc
         KPcKWnWrJVCbwFhqB9o5QHxYn5tTksisiljjH0irTsBTSqwcPnnjtdwRjHvTHkxodZ9c
         Lzx0vIUvWpqkKF3bpKJOghQMMePRgsIGEUvy34k8xlippOvMZ1HjtQFnytcs/2QqYDOd
         +EahWl0gwnK27lQGR12aJaRYQT2UD5wwbz1fPjlt7rtK02guz8phwtGtRu2oMKNQ0yLR
         l8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036067; x=1786640867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CpqTarvM3plb3e18QvLpdCn5d0SiQvgtNYeE1iMGePU=;
        b=SEv/YeegiuvWy1jo4s00Q6qrmzx8muyRtSd/Bbu+JotU4qfkC2TOUmWR8nQLb58n8m
         3oGH5FVu17PZyDjedvdxCtKExU+HsTsOsHVqC14vGm86hrglBsDuLRlqQ0IkQ9+9jjX7
         pErcDmpuhrTRTFaQYk9aTVD3q/A80xr8g+964rjT0Jfadno+hLvX+aziWbUp5Py+P4SR
         Y4Q5axDQhl5wRTtxY895S22VfgGeFwSPSC83IhJof+iU9TuItztXCnITlilul+eKr61T
         cc91xybbUpf2lqd+gihz1Gly4Yosd3rZ057Bo3CgDSDMQ5Avee4kBqNMN3BZURcEP31O
         XgNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmOVtiQmZ1Q0RapgVReVsGjaSzmX60qI8AiPSbjzA8h+MUexnj7ZbElOeA5TV6rBAIY1B+Uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqBlp9TtV5sd7zL1A8yydeWJ9QUD9//BxbObeMYI5GV9BUR5dK
	Iy4jz6t9K8nMLaQWcWEhN+A34YXRajjwhhxylCSrJWrPhXaMMCfRqnnK0AUPk1aJfQk=
X-Gm-Gg: AR+sD12qFBhCaPfAH3/4g7C6cN8DBa4Qqtq2DYY6cURMgIioQRISDEno7F4V4h2ruva
	NmkBFxf9dCYeAmvqpa5oSsVnaBn7FUaGwq2C249dZ737b59000hFVQJaS7kjPYmZjWrX8R7GsQg
	PrvmFej93Yagwidg8fYJNnI/BcA2joC+CqG1oRrwpt2/zb9AJF3r6WoSyp9ld0Yn9D23BPpVOrd
	ZvnHeHsyxKh4bxd6oEajiebwW1/f1kSSh9bvDawrtLEs8krHzH3EJo0LkMxGPeOMnqtqXiMbEvJ
	xmDAZQUwLj8zK6DIn79G3EEjmqWvepBfDr6cpruYAakaHTeeL6Tf5szNk+1W+KhZLqygcGQqvLX
	lvWfX09GIsyde/mtUtv7rbFBlU1wm9Em+ysZUqwcfsgiGBcGNZgLJSM3MOU5q3uBt7bak0nVTT7
	EqneRohd4DdF98yotL/yrYl8d/57LR+YD72VFEo0EnWG4PH/6xiRk3DbmWQO9HTCud
X-Received: by 2002:a05:6a20:258e:b0:3c3:875d:c531 with SMTP id adf61e73a8af0-3cb85dee582mr17248845637.6.1786036067249;
        Thu, 06 Aug 2026 10:07:47 -0700 (PDT)
Received: from fedora ([2607:fb91:201f:cebc:3a68:390a:144e:1b87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158678ec37sm29709378eec.23.2026.08.06.10.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:07:46 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:07:43 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sj@kernel.org, akpm@linux-foundation.org,
	ljs@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	usama.arif@linux.dev, vbabka@kernel.org, jannh@google.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com
Subject: Re: [PATCH 3/4] mm/madvise: skip zone device folios in cold/pageout
 PMD range
Message-ID: <anS_X0uQ5GHXsdwf@fedora>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-4-gourry@gourry.net>
 <0b22acb2-5684-4ed7-a916-d531bd5dc410@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b22acb2-5684-4ed7-a916-d531bd5dc410@kernel.org>

On Thu, Aug 06, 2026 at 03:23:25PM +0200, David Hildenbrand (Arm) wrote:
> On 7/28/26 21:47, Gregory Price wrote:
> > madvise_cold_or_pageout_pte_range() resolves the folio backing a PMD
> > via pmd_folio() and ages or reclaims it without checking for zone
> > device memory.
> > 
> > The surrounding guards do not cover every zone device case:
> > 
> >   - can_madv_lru_vma() excludes VM_PFNMAP and VM_HUGETLB VMAs
> >     (so device DAX is filtered)
> > 
> >   - !pmd_present() branch above rejects device-private and
> >     migration entries, which are non-present.
> > 
> >   - A present zone device PMD - e.g. a device-coherent THP - is
> >     not filtered by any of these, nor by pmd_folio() (unlike
> >     vm_normal_page_pmd(), it performs no special/pfnmap check),
> >     and would be aged or paged out here.
> > 
> > Skip ZONE_DEVICE folios explicitly during MADV_COLD/PAGEOUT.
> > 
> 
> No fixes tag for this one required?
> 

I think I convinced myself it was unreachable (PMD+Zone Device),
but I will double check Fixes and send a v2 with 1/4 dropped.

> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>

Thanks!
