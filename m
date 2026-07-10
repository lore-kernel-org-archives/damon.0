Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF363B71C4
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718467; cv=none; b=Z/zQWWKVRtZasBGVcM9t9kZEJip4OSJt9QXoJ5/MOf7fwkBFnSRyzoC9Hq1QCUzEiWjPHtIeZAIMEctVX5VT4QLYOuDsIg9rmeSSotX+7izm9CUJmzTQphC9zC+Y6yh+JW18qzZplYqNnB3KTMMAaRLcuzUROu5q/zKi4Pbe+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718467; c=relaxed/simple;
	bh=OrArmp546t2joLiGKmZojGNI2jG19j2P4RpxQaXcMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3wJSMCppR2Emg4ipdPjH1XIKgKZK0O0REVT7M7TfxGfPJUE5xwm2/76zparDSHI8Op2yp6ILgW7Q59qQ9+nDTBYAmcbFYbPKBW6CyqTUGXEfMcLUU65YA6D4Hh1KjPf0/MPoQCn+MC21YPQNd9ufdC5T8KJxh0aS9JW0QnC43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CHafMqPm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CHafMqPm"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c29b46382so7328381cf.3
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718463; x=1784323263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=CHafMqPmB4UdrdfrtoDeBwJ8PkDGAFC01KR2CTB5DwMVBsjExgRfzJm9FMakCadVjC
         6XXvAroj1HYLqLETYrdJbPSRp6CioSbj2F+dGlFRBYeEsPbc6Si5/BZ+TtG7wBTXOI1T
         XyxgWHS3boAesXvUnGnqqnLE5Zy1heDGEmLB+YYrGRa69Rr1ovs3UdbVdDV4rhDW3mFq
         xUyjo9TPwxZOvwNW5Gd8z7WdamHao9ptvJWu9+LLXiftRc7WnVJhdRXWObrZKx5fXJKg
         8qV9Jxzkkjg5hszgOw4oKaiJSSBuGcja1UA2dCEJ271jz9bTLH7RDjRy3iXoBjwmzDuc
         R5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718463; x=1784323263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=WLmEpLwFoQVzUKt6I2yj4ndFvjbzFwJcxHFajGV6hczxD6Zz+2mNqkFjQBAn6EZMbE
         x7+5Cn7KAobvLQTbeWWvDqyQnqzvOlDIvQ1GqDMMmmBGI/FNnOobQGQtZGhlEbwswGGX
         /pZKqiDVmuqyO2i1TrLRNUrgCpXpfOYCZ9ikzK/S3GK2GpaFSjArsmA4vHUpjByXq/Rl
         ABeU1oZospTnDl2QmrQMLK4kaMsXonOPdyqM9yEsnM2oqqD1il9F8WSOqnWN3d7q2Vb2
         Te3DzKpD70uVAAMqRkZ8I1Xun82Um+xSA7NNCX/hnNciPZnHuslmH9HS/+YHDAmEHMjT
         nRzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzYAvS2PyzAYTNe4S5YaNwRiSX9+VCfNPGBoJjcL1AVoBRIiElMOOHZwxki0ZTAWqfXbLlpw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4vWLpv0rqtp9nHVpVJtNuEnCy0PtARtq4x94rIjPu4b+jdr25
	vUSFOxdjzBJDIxHaB3GlpsXFsuEjW31s/iXZYDCN3hBF9dZvomCa2CGefyrA6x3YrIs=
X-Gm-Gg: AfdE7clgykUZ9GGGIlcSqopEVWkg538nFThvm4SdpLvTOZn3dju+ST6F2fm91EvZw08
	7Va7+HVc5Sn4Oik8t3PPLzQggKZxveFj6q23WYx09DeYzaiMYhFcaEhnMTuvMGs5W291F3VlvZa
	p9j7GzfGD1sbffduV9IK3tBkIw4P8FJjytpdt/0IyqxsWLy09OTXQOWFCUSvR9uFRWgdoHpYAl3
	OV33NzKZ4Y9wrb87eiDnUP+VIJe8PlYFtFJm9c1PrtuV8lIAnE0rWJrvHyKwlECdBv74gy89u41
	65xeI2JpWXZiExXWg4nh+Tz1aJpgZYQ71RO2t20xVI1Jcw0rl6ETif21z6wIpSPHuK4oJlQtWeo
	9J8H9EhOYQU8DksR1aPlIQYbngGq+oil8aLOM5C4Cm974yxeDS788Zos91VDLxtWpMW1YXA1g+h
	CY4Z0iBZU5Rs0h8yk30AGK2mul01DUuv6ZTEig6imnp79SilbpGdkq1JdIgEaRoTqddo6U
X-Received: by 2002:ac8:5ace:0:b0:51c:7b11:41ae with SMTP id d75a77b69052e-51cbf2dffb2mr6287721cf.74.1783718463047;
        Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm23894971cf.24.2026.07.10.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:21:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:20:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 26/33] mm/vma: update vma_shrink() to not pass start,
 pgoff parameters
Message-ID: <alFiODVaGwd_wYl4@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:07PM +0100, Lorenzo Stoakes wrote:
> vma_shrink() is only used by relocate_vma_down() to shrink the tail of a
> VMA. Therefore neither the start nor the pgoff parameters make any sense.
> 
> It seemed we were passing the pgoff parameter solely to satisfy
> vma_set_range()'s requirement for pgoff being specified.
> 
> Since vma_set_range() is now isolated to vma.c, we can simply introduce
> __vma_set_range() which sets only vma->vm_[start, end], and invoke this
> instead, removing start and pgoff from vma_shrink() altogether.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carry over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>

