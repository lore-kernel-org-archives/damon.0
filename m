Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F43157493
	for <damon@lists.linux.dev>; Tue, 23 Jul 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750928; cv=none; b=qRnRwWB02n8ncgXxhMhlbLXTWwU910siMX2WxMK3Yr1C55ep15J6nLYARNL8f8uYye2SizxHo3PBjhilKwRC7FSaRedzfLuwP1sMsFp1aKScPfprQjozNWQF+4CdkhZm7TslyQiyjDJb+yszwgSw0t6EFWq/Wn8kcwQrQ4thMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750928; c=relaxed/simple;
	bh=TVPc1L8ah/pJaakJ94/QGIwGWqWh3TdItfYh+mGDVDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RX4J9AVKHmJ3rvAf0koeDgWl2lm1q6obkbSva58Bl/LVulGgii3J3aMWKVTeXN0n/bIuF3q5mMfAhoM38OnjXqsd9YYrjXldjyTAUDJUls0u0EGb8bHfxUERKBVkUOCQOxF8sn2fhGz5Oab4pyhl5PYz76VQVV/LdhmIOmNqloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb9AvqCN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb9AvqCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A813EC4AF0A;
	Tue, 23 Jul 2024 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721750928;
	bh=TVPc1L8ah/pJaakJ94/QGIwGWqWh3TdItfYh+mGDVDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jb9AvqCNPdExLJtTo6a2ZcsaRTiO0dyFlFtR/UqyspiF3PDDwv2yd0p3EY1Wz7xKO
	 IgoxhsD2rMksoB7aqVXCf5LiegQu7stE64K2RFXYlw3GqjUPzxlDiVpzKvDRgrmLZ/
	 JlzC0iB/At05koblM47UiNrX77yPLKmmRgXT4y0pj2q+NI6Xx50BhKws2NXvtk9tDV
	 X5zdhb/nO1R9EnmvTVtShDs24gEu5zRZP0s29FTlZECLvWghB/cybk8iS+RP0uOy8l
	 kvdyC/fMVKGuMmXQeGS4QgYbCxy7b+CxKh4OWu5T+DQY8xd7ij7Yy63YLZnSuj+W+N
	 jK4c4kdRDxvsQ==
From: SeongJae Park <sj@kernel.org>
To: flyingpenghao@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH v5]  mm/damon/lru_sort: adjust local variable to dynamic allocation
Date: Tue, 23 Jul 2024 09:08:43 -0700
Message-Id: <20240723160843.99979-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723035513.20153-1-flyingpeng@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peng,


Thank you for patiently following the discussion and sending this, Peng!

On Tue, 23 Jul 2024 11:55:13 +0800 flyingpenghao@gmail.com wrote:

> From: Peng Hao <flyingpeng@tencent.com>
> 
> When KASAN is enabled and built with clang:
>     mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds
> limit (2048) in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
>     static int damon_lru_sort_apply_parameters(void)
>                ^
>     1 error generated.
> 
> This is because damon_lru_sort_quota contains a large array, and
> assigning this variable to a local variable causes a large amount of
> stack space to be occupied.
> 
> So adjust local variable to dynamic allocation.
> 
> Link: https://lore.kernel.org/all/20240711081051.66560-1-flyingpeng@tencent.com/
> Link: https://lore.kernel.org/linux-mm/20240719174234.47017-1-sj@kernel.org/T/

I guess above two links are for revision history of this patch?  If so, it
would better to put together with revision history under the below '---' line.
If not, it would be better to add more clear contexts on the commit message.

> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

Except the above trivial comment,

Reviewed-by: SeongJae Park <sj@kernel.org>

I think Andrew would handle the trivial comment on his own when he add this
patch to mm tree.  You could post v6 with the above my Reviewed-by: tag if you
prefer to, of course.


Thanks,
SJ

[...]
