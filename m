Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C782B9BA;
	Thu,  2 Jul 2026 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951764; cv=none; b=USxEPwcNOczDCLmotIbAf7Z+dg4GfOy4yfYX1+fdi6iu6cTJEtSzeHOmEGPBUgMIy7jh2oVFlsnFpAn75ljXHOjuDOPKMzRp9z8TzX+AesheOuZtnpsp/X+ulD5ODkpL+xezWEVpm+6/6DPOrtfR/LoepPtFkg0PzPgP72ni5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951764; c=relaxed/simple;
	bh=O18wXw8F9dweGCBW+pPTHqRvdgcI4ke+tZHfCoBjxXg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g/8asOWNrVyqatAXcOayUo0qtB92Aex0VeTR9sgNGrFxjDzcHNM65fnZHjsXDTmiQMj0vp8Z7q6MF7Iu/xC48cjYv8Eea4oSwhCiWkF93D4/bRgAEhJZcn47aPLej1Iwh2ux+o1GWeCB/FT5bLgXD4upjcySr8WWb0okGyih5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=omO8LYAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="omO8LYAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB121F000E9;
	Thu,  2 Jul 2026 00:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782951763;
	bh=23rX2vX536XbffkVXQa9JQ3/w2KcnNzTuTyFxq6wHEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=omO8LYAAz+LE3nowi21ZAn6dBOxTraIfOelZ6vITjCEYQvO7y1BYA3mdLO9TbUnUi
	 yla7SWNMRmq1EymamSkyI1IP+kts2FkuHyy4bmcq9XGGxENpzPv2MHaUINOdXBsWO9
	 zX9XxTDlz6JO0EwRzAKRNgkMb3VCoqHXehTHiUlE=
Date: Wed, 1 Jul 2026 17:22:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 14/18] mm/damon/core: remove attrs param from
 damon_update_region_access_rate()
Message-Id: <20260701172242.23c01a9affb94bd0cb7696f9@linux-foundation.org>
In-Reply-To: <20260630044859.152347-1-sj@kernel.org>
References: <20260630040812.149729-15-sj@kernel.org>
	<20260630044859.152347-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 21:48:58 -0700 SJ Park <sj@kernel.org> wrote:

> On Mon, 29 Jun 2026 21:08:07 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > damon_region_access_rate() is not using attrs parameter.  Remove it.
> 
> The function name on the commit message here is wrong.  It is
> damon_update_region_access_rate(), as you can show from the diff below.
> Andrew, could you please fix this up when you pick this patch?  Let me know if
> you prefer sending a new revision.

Done.

Thanks, I added the series to mm,git's mm-new branch.
