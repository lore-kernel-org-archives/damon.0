Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D37434E40
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441616; cv=none; b=u6ZTdJp33IEDUO+X+jv9uP4RGj/3d+6utB2YiCGhK9BsTyF3bD8xsVlfiAmofD/4mSVYSGanGlt2UJb+u6ysmEq0IpwT16bOWRhIRUpWKW9p7EreTjHof659gtuVRoJL5DbUTu99BadNjsBoG/mAb4hKtd+w52d1wAE5tuId7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441616; c=relaxed/simple;
	bh=YNUiKnsVmS0YnEoi5UBidfFcsIdy4Lv/4umM1P9hbyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AETg2uRn3aQ9CFOgsPZdeNz3AvbPROFzBxBR+ymKpIXI7V7FiJ0iJvz525qBa+/3K6NGR4ZRUfrcH0lUEgJFPAoofB40SMcleiq0vl0WdYr5o7AyIbVr3T3YhVERlvbrK4N8eP3okeCzMZUR7jxUSlfTuDg9pSbnCY5QW2sEIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DgKeiTpC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DgKeiTpC"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9204711e831so370307185a.2
        for <damon@lists.linux.dev>; Tue, 07 Jul 2026 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783441611; x=1784046411; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3pPJvCom7n6xLJkZnxYC/ipfbqNHo6N+N3CeZviAw0k=;
        b=DgKeiTpC1241Cfioz7Dg65LdNkcANIi1laldlaYY/ldXRPsuwvBKFWPK/fhqp0l2OF
         FD/fmwNNIjbhr224B5/yRDL2C47QHrIjuxQQmWziD1Ph3Ia6UOSlkSOlRWIr6Tm9g9jy
         JCw/1DMvDlZyxJ1RpkVKf5HKS/vMbjEiqSF5ps1AHNbxOaGnA2udpL5rhenWJY2+Et9G
         mz5XaPIXJNHdJu13ys+G+kKT3VDXYCEmPOd2/kny3rX77IOKD9rr/j3DHatgJxXnp9PR
         14ZiUY5bhjsSDIqIVspNuwLJnpaxmcG8utD1OOOW3xignrFtlupX4f8y+hXA6Z5L4Fhv
         DFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441611; x=1784046411;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pPJvCom7n6xLJkZnxYC/ipfbqNHo6N+N3CeZviAw0k=;
        b=N6EeXhEMtm4KSHxalITWD0jJ0cKVrQdAj7BeCqhN5uM/iLZDPXWRGEeOBO//vOGhmQ
         c3e9BaeUfjK5JQ35NX3B+QU1xqmaOWN2y8nMhcAHFKwOKk4NJyo+bDCKCpJcl2Y170gS
         MUKnt2o7dKi6/t40GPF7mavhYCkwGSqZ4fLzak+8ajSYYYMbFHj97e1cVn4/04VgjtsJ
         vPrtGoW5wTk3NnkOPfHyd4LsvEO0/oJv5+oU/p12N4az/EJJSqvW8svD1QZPexjZMjpU
         LQ0BU4pkWROoviJWiu266yYzMITyBtr0mgLsJVliFl+UkY13/0MBnSwPc/L+wPWNIYJk
         nmAw==
X-Forwarded-Encrypted: i=1; AHgh+RrMGyBAoTvOSOeWay0QuABiHpa3Sok8Fjoq8ViRBD5xE48plBPRWRYQyhl4k2o5F0C+TTyW8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx23pQ+7cqYLQ4V1WAo5XlEf4ba9EqBKF+VOfAfztxKHaGo5btN
	loFZX0S74g0bBdPEenSmeOdqZcDD62KnDSshhYkHriFhB5Ly9srirjIpBRq+EsRxXVA=
X-Gm-Gg: AfdE7cnUb2kywifT15z3BzJoTTeHiIMMmormdGsfjHqVbjTlztfBcUnFM2no9M6olMj
	kqy4JedN4LvIc/I7vhpsGpF0XhJBb+h9/dqVeuVAocgitzpe6+mULnQdmdfxhwf0koSR9nOF2x9
	wbXN4ZyfNg6sVKPsFenDqoQ9VhwGt0O6ldPQQDcddgGN3hC304RdJwsFjc8MsSiGpu30wsEADlg
	tK7LitXxuw7wyX2KzxMdRCUktyNTdH6auFoHjSeYmy4dmzwxOdW24fCgUKCsgTjq0ed6RuLWeBb
	B85mL7W0IQk+tkEYsisjwbXB9Ov/YmcZMvIjQfJtwBkkMX9V8B6sXESQm0GE35bfqy8q79QcGyd
	2nnDnN0Xw+4ba2KenW9g5QySopzk6nhOxf4YqFNM/mp7IhLHYP9r2KM482MdrwlUBv9vw1MNCIP
	B9ejxKFybrJb28ybqI7ReQYXO3Wbo+kaalPWHRAH+uwyTM3FgoDLelZgb86TK7iSCxGrpuCSP92
	9sy2N0=
X-Received: by 2002:a05:620a:a807:b0:92e:c118:18b9 with SMTP id af79cd13be357-92ec1181fa1mr324497185a.88.1783441610850;
        Tue, 07 Jul 2026 09:26:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba41fesm1231337385a.17.2026.07.07.09.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:26:49 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:26:43 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 12/30] mm/vma: clean up anon_vma_compatible()
Message-ID: <ak0owyNkHX6mw4pe@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <5a7a07bd2a774989849b0fea84f758059ed914df.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7a07bd2a774989849b0fea84f758059ed914df.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:23PM +0100, Lorenzo Stoakes wrote:
> Break up the existing very large conditional, add comments and use
> vma_[start/end]_pgoff() to make clearer what we're doing here.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
