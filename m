Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84D244665
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755360528; cv=none; b=fYw2ak+csvyBk8A5rgbroJmFCnkg0xBMz3ZIn4pHzgMvgnUN8u1Caq7YYxPeWsByA63FOx4i1LQc2+RVQEr7flZpnaI+808X/NO6f2pFCb+sgJGVzDIQ/7XnCblPr3Je4FMFeO98HhIOrlW3khJm0jwCtI/YwH2DPXLKQYoRpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755360528; c=relaxed/simple;
	bh=p6ysJ3B9QPz1TZGVAPiJzt8niKULf9on/9PRLjBIiD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ki/B2oWOrwiT0tjncmrDqvbbxUWzE/nrSSG/Ep00gmPLKlbn7uUK6IlPa8YuMsqBaohWEPllqYIzp3yHocSr3YuWm0CZQI2Edmw7s6yhDflssOCxPZxOxgjYamoiiA5NzPoH0OYF4A9LKnkTtXzrzzE2BIJinW9HgynljDLpSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGCzhrsU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGCzhrsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB06C4CEEF;
	Sat, 16 Aug 2025 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755360527;
	bh=p6ysJ3B9QPz1TZGVAPiJzt8niKULf9on/9PRLjBIiD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGCzhrsUyBntZYjf1IBSt9I/9mCUpvDKzOydkPEW/sB1Vq2Go29F1JUkfs+aKJpo6
	 C7JUXhzN02Wk/dkPiZmNx9E2We74CNokxfTvhj8b9ZtY9fW5m+Umz5khTdS3kTAG67
	 WrOsA+kqHsHeRt4/WRF93tcfQ+mwWitwx8ZILFIGd4Oo3fS70cEgN4EvqaREgWofww
	 O8PGxxBB3HSQkyel+s9oNZEYFJm9+TZm9NN+MX6G4Cv4JrGyVlBQ73Kobps0wWjFDW
	 GWYrtZ33aqJVgKutXK7NGvx0F15wUds3HIMcIOMRqUcIhPiyzUd+pkkEt++pPXRAVa
	 It6fWlWlDQQ0Q==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 mm-unstable] selftests/damon: change wrong json.dump usage to json.dumps
Date: Sat, 16 Aug 2025 09:08:45 -0700
Message-Id: <20250816160845.63600-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250816014033.190451-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Sat, 16 Aug 2025 10:40:33 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> To print drgn status to stdout json.dumps should be used without
> json.dump. Change incorrect function call by typo.
> 
> Fixes: 441f487d6ebf ("selftests/damon: test no-op commit broke DAMON status") # mm-unstable
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> Changes from v1 [1]:
> - Change patch subject with DAMON convention 
> - Add branch hint to fixes section
> 
> [1] https://lore.kernel.org/damon/20250815094029.133063-1-ekffu200098@gmail.com/

Thanks,
SJ

[...]
