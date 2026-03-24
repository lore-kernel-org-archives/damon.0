Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3024DD15;
	Tue, 24 Mar 2026 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312077; cv=none; b=uT0jRuxex6XGOq5czIggMMUS5D33GKR/gUyAfAK8/wDicZFz1eaSuMj/Gje7pXrSk0v85/hUszxx8PjQNkm84EmIEYnj/R4G+GsRqOEc/FhEUNd0c7aNTuv4stDEXsuZgOJ9hBFdadXH64ADg5Hk9o+3UPeEFnJCB+eVAo2s4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312077; c=relaxed/simple;
	bh=CXHUdTyfTNdbD2JJq9Hsvz57+3dMhKPZJcBepqZpPew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LP9ha+FjZWZa+r3TJ0j6ijcoV9nMm7QypPk+yCrPiZy1Um5ex+pnoX+dRcxtsdQh9+BtkIaiV0/Wedxdg7SDOlwuBiu3KKBxD9TTGrrrqPUbujLtt3yNUiLFHsCdriwd24gBp0VgqmwuChdCrA2lhX+gGQIlEYsuDUziyDGWuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3d5O1zQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3d5O1zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C083C4CEF7;
	Tue, 24 Mar 2026 00:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312076;
	bh=CXHUdTyfTNdbD2JJq9Hsvz57+3dMhKPZJcBepqZpPew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3d5O1zQ811WSnUGMoslPtMT2h/0SBlgLhNZQuaF6NXRz3i+qZyYPY1eqVGbTjVA8
	 J/pIHmbNivVi9QqgRhCxK0LhmUnKk9vScprO2uoaZXtiaGCJTuZNDdIfcsFZcZ8J1W
	 cpEncRyTN0vhLrD+wfJezFHkNIG3/MQijZOuMGqaTfd1Mzn/cBOyQx8e5SBAeZ334x
	 OzFOg1Q3uV4F3VNB5pgZRBvgbqqLtFpysXR89MRU9ulBYdemeNJsWGGHhKgnkxmbc8
	 pHhCsEuCmDGOjs2CmsyqwGwwlwLLnQ/p3FMbUgEJYv6adqtc3ngr/k4xtjKm6XWNeH
	 mtYnR3+dY3TWA==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: optimize kdamond_apply_schemes() with pre-filtered scheme list
Date: Mon, 23 Mar 2026 17:27:49 -0700
Message-ID: <20260324002749.86524-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <43C21A6B-B27F-428B-B65C-1BBC9D66AF38@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 15:18:16 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 23 March 2026 14:20:51 GMT, SeongJae Park <sj@kernel.org> wrote:
> >On Sun, 22 Mar 2026 22:56:27 +0000 Josh Law <objecting@objecting.org> wrote:
[...]
> >I'd suggest to hold this for now, and revisit if this becomes clearly a
> >bottleneck of a real use case, e.g., a user claims so.
> >
> >
> >Thanks,
> >SJ
> >
> >[...]
> 
> 
> Yep, ill shelve this at the moment. Thanks for the clarification

Thank you for kindly accepting my suggestion, Josh.


Thanks,
SJ

[...]
