Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB04A21;
	Thu, 26 Feb 2026 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067454; cv=none; b=IMakncKdSJgC2xx49g/lB+hfV27Ky311oaMGkN9FchKZgvdq9O52VImslMut7oNe4MHDsoXm4CWM0Wb2EdiCG+9su87vkYePbrYH1eaujYAZKT6wp+SS8B+TKoQ/pzLB1eoFk0DCu0BOhcIXh+IGA0ACaN2FNVWLqmDEPHFZk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067454; c=relaxed/simple;
	bh=q+CQwYcdbwUOFLj1CvBSURNbNPO+bp03YTfwhYPOTHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0L7MQitBQKFk6WwCY+2Cd+UlcfmdUO1I+Cxt9bGJEjk49MxDeNvgwCjkOEmdLoyeFghQdZa3wBK1OoeSpzIAz8JDTMnqQ/7mUdyGv/Luit2UE50WMAPxAjgkiGWAGK2ZCdv96dwoTXzRjiEm2cNTI3ecKYJd/HlUryleLr+6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHjcPwVM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHjcPwVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B9CC116D0;
	Thu, 26 Feb 2026 00:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772067454;
	bh=q+CQwYcdbwUOFLj1CvBSURNbNPO+bp03YTfwhYPOTHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHjcPwVMIAiYYEGBpfx3lHSd2/P5d+v7r7FMnMdbXBEreVOIPGcqXj/x8x37W0m+P
	 ZoVCh7/EYXI7+v2iQWInc4bblq/Xo8qwfvYfa0MXMm2X98mvfcxxswIVe/XB08gGmU
	 dL+I4Dg36/4j2fxy05Tw2x4jV92SNhMQ0D4hH45lRJ2oroF+b5TzxyCO8XmhdTmgTG
	 Z4BlqIugl8mG7tgBgxAkAjF18S3fMuP7xD6i2rYKslaMD3qyHa3CrnASC8Yy7gU2ZD
	 W93qa8MSTPadb6O3hrKYNoHZgiqXuhNtD2GcOiTJXVo4pAuiDD4ab09sYrZcuJamKI
	 mDdnezseFomPg==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v3 3/4] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Wed, 25 Feb 2026 16:57:31 -0800
Message-ID: <20260226005732.7839-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y16T-yNPq75s_PWwEJAEZ=r1YVdd7AyRMA2DtS=BdkZ3-w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 25 Feb 2026 10:46:56 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Mon, Feb 23, 2026 at 8:27 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Mon, 23 Feb 2026 12:32:31 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
[...]
> >
> > So, the overall concept and definition of the new goal metrics sound good to
> > me.  But I'd prefer having less optimized but simpler code, and nodes boundary
> > crossing regions handling.
> >
> 
> I'll prepare a v4 addressing all these points:
>   1. Fix 80-column wrapping
>   2. Remove eligible_bytes_per_node[] array, iterate regions per goal
> instead
>   3. Handle regions crossing node boundaries
>   4. Pass scheme pointer from caller

Thank you for flexibly accepting my suggestions and listing those again here.
All looks good and catching all the points!

> 
> I'm currently on a break and will send the updated patch after March
> 10th.

I hope you a great break!


Thanks,
SJ

[...]
