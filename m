Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A8395ACB;
	Fri, 11 Sep 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133611; cv=none; b=s6lrJb5Tfsk+2D+0shSif6HvFTZRN9xzr/msl+rATYPKQ+KmxTTkaMGFM4vraqpFOFGF3GoOPMvOveTWAclor0v/gxuOkoHighqahayogcdCdbvYNw4ba0J26u3+lOenlJRAGYRKgHkYOtmNUTRIW/M+sSMZW9LseIgbXE2ejs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133611; c=relaxed/simple;
	bh=hi5Qe91Z8x5MCphBI31vINDmGjRBaB6ap8a5cY8yJ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqJcD001+z+aGUYw3b+ALvSFbr1vmFwSx5HvDjj4GhO2RKpFQNjOXZ5LAeEUm/k+mPu7JWxDEoBi+xJDLOLHGuxolTysTrBJ8QgJTVRB/z+aMIdIglWgiJjFM+JgF4PXjDCcJgJa4plPpQWJkR46EuavK6c6Zfx+AEmUl3nfhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiTVlcZ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiTVlcZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522F21F000FF;
	Fri, 11 Sep 2026 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133608;
	bh=ncu6ec8eT9DbAcxyd0iWWwPt3S/kddThKenFXEHMxhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NiTVlcZ8udwhihsn5Yc6rp5/JYS+E8o6tyz4qA7zT5HIhe8ubYfMnd+lmG9SRIzx2
	 nggHtW+jBhoAgXGpER5ny4Z0Xb4xj+Sq1NpkKFkUz6EE+72gdg3X/Pu+BFUsbvZCIP
	 gx+2Ab4QF+7EzemyoRZnpKwyw9jTMwBVTe3RITK+CPohGDdy0DVgoaeufQ2u49H5Ap
	 ktoaWQ65dY7cX2sQOY3VAESmvh9wHNCJwVemAB7fZjD7IomyxkuFo5foSGL4XsG5l1
	 1M+NaJidWuLfTVPXg+M02Eu+LcJLmE07ji4ctaMPC2wjZGBBTg7fLCyAOgbxbW9kO0
	 qZNd40RFBzFDw==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 5/5] mm/damon/vaddr: support pgidle_unset probe filter type
Date: Fri, 11 Sep 2026 06:33:21 -0700
Message-ID: <20260911133321.91720-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911020118.37585-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 10:01:10 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> On Wed, 9 Sep 2026 07:04:07 -0700, SJ Park wrote:
> > DAMON virtual address space operation set (vaddr) does not support
> > pgidle_unset probe filter type.  Add the support.
> 
> This looks good to me.  Checking the PTE or PMD young state together
> with the folio idle flag and MMU notifier state follows the existing
> vaddr access-checking model while making it available to probes.
> 
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thank you for your nice reviews Lian!


Thanks,
SJ

[...]
