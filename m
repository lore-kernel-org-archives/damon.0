Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D742189F
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748496; cv=none; b=Pal0uP0xuSZWzh47WJiqk/gPy+2+vFNxkWywp9QSVmjjYRTOSBfptYFuK7HCwfwdxTpb83PZeVem37PGhaMZ0HMGmHrOwlU2N6Vgo2M3ewdxFUfro1iIK2DB4brcdxYuQjsEVJvZzTdOcqnnt4WNLzQ0W2fX12CHmKWfTmelMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748496; c=relaxed/simple;
	bh=vSc4ORRRpUbp5nwMJk1U6F/78ha49jf3UdrgblxYv9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmgQyzakzX+xHIqKYoLaO+q6UfrYLiCp9j+9K2DgcFTl5S6nMnRiEJ3hlfjsj2eMl5SHpCxnXBt+LFsX7He5RouNlXxevqe8ePGLZpegXL0AcBoQakXMiIWHu+QArB3EvLZsfk4qhfO3EHGgxZlb/xA7DpToJcxySdyT91RiBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iIQgt3cf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iIQgt3cf"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f0e5e36912so6131566d6.2
        for <damon@lists.linux.dev>; Mon, 29 Jun 2026 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782748493; x=1783353293; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4r3nyg8MsZ+G0ckW9OOGJtlL6QAvCNLsDtm+wiwuKtE=;
        b=iIQgt3cfcOAwo1mrTmq2ufd7KBn7KaZZcIcwoYn3k/1jUjMHWhQGvQ4DQ3gdJVdNiv
         KWzQBVBW/ZL7XV/e2KjuKu2Zpg9i6fyTNG4Kv3m/G5jB6Znl9LTwS+ixCMc7GI2VBhik
         cO5j2exnCvxvPGgEQxFxF1HIPpi2nKZNOe8P+6lOhGTTR0wXZki9pQ0+HrKGWSnUMtxo
         cNIaiBPACH2+lUM7D/d/z7iry8ibk/Wp0if6q+Fr5Z92SVu//XAclq6DiXEO5yV1ilgi
         KBXBsaWOwQN6PO8T+2OHN362TYHjzMTXXgndYOp6HbtgRmOKbE/H2dcqzwzyuaMBJOVr
         d1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748493; x=1783353293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r3nyg8MsZ+G0ckW9OOGJtlL6QAvCNLsDtm+wiwuKtE=;
        b=RS0r64cDzQxV6tGV2hX03wW9qufiVdDKsM21h+zB8Hl67trJaFW+jlbYj7RG33hnv4
         666ynobhvgUc9xui1q9xwd+X+L8xj4vPDtRoGz+r4EbGcrJXJ56h9EFOP4j/6ZsKTFYH
         0Pronpt4e8VxyxeXmS5DYI7F5ruwVD5IkDZ9vbHSESYBEJZ9ZN9lmkQnkD6EAQloU/6s
         bZiEI/qCd871KbZYy7G2R1WWFtblKbHyXl9rGRrsCsbGhWEaOf2ERDQCtzx3xWpHCApG
         0AW9/3oIouMEgdOJXYa2oC+VW6oxGhWtihr0oDIIQ+hhM1WuA2rMIXEHNVLJT2lhurIb
         dq1w==
X-Forwarded-Encrypted: i=1; AHgh+RotvgV2tGrDhvttaRA08SgZW+1zLzgBQycoyrXb6Kq7mNe7e9vm1+3iPY73g7Jnv6T71QOanA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzstxY5caT+5pAgBdK5zQxeFAmZJ9SH7y3TUbwrCUq1veelsOjY
	wGV3fsGJHx39QOC5xVmzogtUUA4M2gLYpDBc+BTtKOzpPELec0ardZ9uUj6uoEw1MUM=
X-Gm-Gg: AfdE7cnyAX72m6bjs6r/yWbM6gBTV4YjI4UPuHB5caoKFc6hbsXI1I5rzSzPLtmsRVe
	E8j3ge+1zfAW97jWvq8218HTn7F4MfINDYVv34Ve2sAJmjmSyNlJa4SOWqG7FoNgrE/MXaynUM8
	Yyc295b8AuWv1OM7FuEcJpzLXPyy7uWhiaQcYUVuP8EfUPFg2zI+xLYZ1iINhyxGnea2BxaBuqt
	xbVrSKrBju71l9XhNpFiit+HPHNkvbo2WzMMnCjbLnzMNUiPeAX1N1AtDG/zOqrRUqbov9/y/BC
	iZDEMpMQ16wo1ONFVdomo+wFLDC04YUdK9Ci2JrzgNtSbKE+mOvfsEKJmnyHWAfffa9+DO8McwS
	FXw7UVfuO/kND21558zuGanwq5QS2DO2Sb0XaognNwjkt9jQGYL8wbdjwIAxo6t2FaLEB8YXCJg
	sXozDWP2M6V5oODej+GXr4MhcIQu716B8jnebX+R6GJG17kjFXfepal0W1SKK7ZEqb6RUaEuxb6
	MP+Csw=
X-Received: by 2002:a05:6214:c65:b0:8f0:5b55:1f6c with SMTP id 6a1803df08f44-8f05b552223mr58558406d6.43.1782748492988;
        Mon, 29 Jun 2026 08:54:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a26f1b34sm1726396d6.3.2026.06.29.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:54:52 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:54:47 -0400
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
Subject: Re: [PATCH 04/30] mm: introduce and use vma_end_pgoff()
Message-ID: <akKVR2wNSjbLDt1-@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <e379a1cb6a897126ad96e3a263fdb91d6c11f6cb.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e379a1cb6a897126ad96e3a263fdb91d6c11f6cb.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:15PM +0100, Lorenzo Stoakes wrote:
> We already have vma_last_pgoff() which retrieves the last page offset
> within a VMA.
> 
> However, code often wishes to span a page offset range, which requires the
> exclusive end of this range.
> 
> So provide this in vma_end_pgoff() and update vma_last_pgoff() to use this
> function.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

