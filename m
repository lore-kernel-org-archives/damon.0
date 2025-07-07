Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D8749C
	for <damon@lists.linux.dev>; Mon,  7 Jul 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904940; cv=none; b=UN9Xan9DN3ERN9+x93Q3YXIh3UHus8JlN0I3OegMh1NYnjXu3TNRnuF3+2j+X08HhS85W5exoUE1D3FSypZw4DWMTFgZBVVG/xOZqyvrlJYOCUohFbHFmReLi1lvjeHt0tcsCGSnp+Nv0Kzeq3xDWpJfYr4riqSlerD6d35+O0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904940; c=relaxed/simple;
	bh=7yLfRRZIuWWLkhAeslLkA5j4KcZb4nkaXOKL3vU1+pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jP6a2w8kuxJ+w02TpRek+X7L5294kyyaZJq/0iPhT7TbNe2q9fs0Tt7xi/IiuqddkVySXoxJae5eWpJIh7wNwzo140B07QopXcdJiz8NsmcOKNRWl1MaH9KBYGneBlBIlf4SDYeTFTctwxkyvhIr5UYjn8+rIAqdxzKP81tDGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqD1DHpZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqD1DHpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63BAC4CEE3;
	Mon,  7 Jul 2025 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751904940;
	bh=7yLfRRZIuWWLkhAeslLkA5j4KcZb4nkaXOKL3vU1+pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqD1DHpZ5CBoO/g2CSzNfYGNMMMYeP4rBSittZV5+TGxFOiAL171Anngt0jcGhhgS
	 8YjGL/U0h+1Sc6wTRi/snES9C4oWNhoFLC6ia6T63eF86gZsFwDc1ez+CkYJURRId7
	 xPv47/YVm2XQWhRZOae5s9ZzvvEgrN5nsp5A1yUVeLPeZBpWJUvh9NW/sIURDPVnWH
	 TGhBRNWocgq2ErEPPPf+CbrXla2ynVksBNNU5wJp8ByLa/BHu5UD8kzjvn76ux2Peh
	 U8A3yfzzN0g9Ga759VAOxH7OoRoLmVVHIJnwLO75v3EUU1nTO89qWtb6ADjTAU8Y/n
	 SCoSfJHg9O4qQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [PATCH mm-new] samples/damon: change enable parameters to enabled
Date: Mon,  7 Jul 2025 09:15:36 -0700
Message-Id: <20250707161536.85426-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707024548.1964-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Jul 2025 11:45:47 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The damon_{lru_sort,reclaim,stat} kernel modules use "enabled"
> parameter knobs as follows.
> 
>   /sys/module/damon_lru_sort/parameters/enabled
>   /sys/module/damon_reclaim/parameters/enabled
>   /sys/module/damon_stat/parameters/enabled
> 
> However, other sample modules of damon use "enable" parameter knobs so
> it'd be better to rename them from "enable" to "enabled" to keep the
> consistency with other damon modules.
> 
> Before:
>   /sys/module/damon_sample_wsse/parameters/enable
>   /sys/module/damon_sample_prcl/parameters/enable
>   /sys/module/damon_sample_mtier/parameters/enable
> 
> After:
>   /sys/module/damon_sample_wsse/parameters/enabled
>   /sys/module/damon_sample_prcl/parameters/enabled
>   /sys/module/damon_sample_mtier/parameters/enabled
> 
> There is no functional changes in this patch.

Looks good to me.  But, I cannot apply this on latest mm-new.  Could you please
rebase and repost?

> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
