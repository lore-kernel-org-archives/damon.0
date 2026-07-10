Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879933B3BE5
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717937; cv=none; b=lM5c/U8lHZ9Y7+jRm6LIIpKK+NRKK7R0FaBh4L9F+Gzn6A7J8fbl9u+vOfYEzDfU9jDDcMG1d+/dbWGBATe4EMZlkOrsNiDxDsBtQWEzFoKzV9ygntoA/TE2WRAyDJZeJp9GU63wE2vTcf53Any3TyGgYYJ/W6FuSApjQf/WfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717937; c=relaxed/simple;
	bh=dQzz6EcSb1LSSq/sqBlPjvInRxBfU2sSme6h83vG2JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOw296o/s10oCLQhB3U2D3Nd/0yjkqin4WTZUl149PAFlB2xJWCqMxzt6IyheckpE4yRq/CMq3b0vpDli7tSPVr2w+T8wp767zOQ9isstozI8wEmuKhGLqotNKlb37C1wPMixmJE8vtrvDaRwMW6i0qHZgz4G3bNX4If72ScMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hrbeeCBD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hrbeeCBD"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92eafc94c9cso72490585a.0
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783717933; x=1784322733; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pf2tO4nh1364RXnPDWacirAQrZ5x9Oo1qInEIWqsetg=;
        b=hrbeeCBDqxvcoKhXxq8SWsJru9virdeiBYWzKEiyF8H285ePiE2JR+IgGKXamYnDS4
         uTpazOZ7EQ/pZpR81LHxuRk6COrgwv8XcvGsa4qT/8LNo/OqqtPIdB4uinxE8+P37bpU
         b7pUAgvrtHsXKRT7mG4heaYwBjggAZSwgu89amW4yZthl8EieREkTA/vSK/GMeL8A4hE
         Li6hHj0m1/jiLclN0yhEY0D9U81JTloaSAQ4RmANaB59Sw+LgOgiPGCeqjA82d+xg/hP
         7ITI4Zy/TxSp11cBcMlgWi92sAlrLr4hkK69Tye+OzEphx0Jbm8DhtxFSdi319XDH9Ib
         NurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783717933; x=1784322733;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pf2tO4nh1364RXnPDWacirAQrZ5x9Oo1qInEIWqsetg=;
        b=cy7FQR+bIZ4MUFdoDoYowUGzhbiJI+z/uQM31AJXLoOuzQGoyc3n2CtqB5LTluDpxn
         XhZtfrAMEyhdP/gT7eDzzB7I3cYlhXFdP7fVMI9WVaBQYLHVypWJb8+AjG8UlNXclpy4
         9ZtZArMwqgYD+KlUv7I0OuAUZ14LJTls9pdIiA8sYGrR3RnWXrWFqujQgG9QLP7C2/9u
         9/YbloLmLhNevLAlHR7bsiiQdDl9wZTwQ6YRAi4Q+unHRotNZU+QUpPJdzVSEHewSQoW
         l+68xI9GZovddGNuZ8VKHAq7xX7SFMGMXEAMHt2ZfTUkppSHfaT1XwVQkoI5dyf1fey9
         EJiQ==
X-Forwarded-Encrypted: i=1; AHgh+RobNtujQE4V76NM20q2Z8rA2ltpvWz6f3wgZJ4hRKIm1rt0dH41fhq9QcjXQC4mcaDO1vUgVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUufp+JGe+PjIspThpe1cwKms+akYcdTOwuyNAj5qrj1zLSbUi
	omrbOCxKRIzAuCRY4ekVPBBgRKEluQv8xtqOarE/vRl/7tYC/QR1+dmrEo8Xx5BbsWk=
X-Gm-Gg: AfdE7cmGV+aup+VJk6+q64gFiKkGh/0YK/vRTYJL7fK5wb98pxFMoEti9H4qZ1BRzVN
	O/y2XQPGx4l6YytnPgxyYyn8XEOPIhrlm9qVOGVEfday2PvLYy2gKclKoKaM2r4/l7RdMsdkYCh
	1/PMT1M8vlbVRotmMxH/ayHuTlLwn481cAhHq7T9fRY/6MoUg5/SXazx35kyvZW21lEjCyHmreH
	FjT0/sG+AQgp5MtGOXcH/KkIMtro1ULH1L2WVEOHcVZ/BennjsyHRuAGGCL7h9ipQ8xtBdd1/oB
	9NoTZKWfj/rXrCZYJmWj/33Z8MKL6yIe+P+sxgH6h3DngjKg76HNnGlPQBsmpts5OKXyZtauWEq
	ieMGu3xqactYiigaeNLyRSNJ4I6F2z6T4VRUzlJfAicbyU7yi/3czKW7v9JbfWkurA3h/Xls4pn
	dz9mu3nANoerni2T/+qMW9xktlgXIPcyt//0ZETqiSk3/PRvzDM5tqGNvpY8d4KQ9ExRbQ
X-Received: by 2002:a05:620a:1a24:b0:92e:7c7e:9c9a with SMTP id af79cd13be357-92ef2b32433mr108915185a.31.1783717933240;
        Fri, 10 Jul 2026 14:12:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfcb0dsm290194785a.25.2026.07.10.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:12:12 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:12:07 -0400
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
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
Subject: Re: [PATCH v2 09/33] mm/rmap: parameterise
 anon_vma_interval_tree_*() by anon_vma
Message-ID: <alFgFakGEcg6hO6E@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-9-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-9-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:16:50PM +0100, Lorenzo Stoakes wrote:
> Similar to what we did with mapping_rmap_tree*(), let's declare
> anon_vma_interval_tree*() in terms of anon_vma rather than rb_root_cached.
> 
> In each case the rb tree referenced is &anon_vma->rb_root, so just pass
> anon_vma and the functions can figure this out themselves.
> 
> Also update the VMA userland tests to reflect the change.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

