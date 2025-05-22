Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D942944F
	for <damon@lists.linux.dev>; Thu, 22 May 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934176; cv=none; b=h7WkH2R9m08jovz+I1vWG/rHKaavRzwuY0javksdC4D5gKPn/Sr+H/G1W+0i7xKY9PH23DqXNy7L9q6aP6ZP8LaAfwYdE8JYCaj3fKE1+sOYADMFCMCHkWbRRq6F4qXJqoN6wUg4X048GYeVK7tevMbmJf0eEy+kPFqWh8VK51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934176; c=relaxed/simple;
	bh=DStv18KNDG37zfoMOV7QNwoq4hRY3N+ggxj4u2v7e/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGzjxGaJoSPa0jGYmpKPZkzdiqnYZ/kth5m/MIuDYpqcgBBQx173oIgQzQHHZ3JMwPZmKAp4sYShw1Wtqn3m2SKoHPtPmwxDjoz/MtDvh7KVvD0/+cqssmQdSCFAJ9TokKIR5V837pEGDXdz74b59sRB3GBCxGupuIpxJRtUQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP/Om+Rv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP/Om+Rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C3BC4CEE4;
	Thu, 22 May 2025 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747934176;
	bh=DStv18KNDG37zfoMOV7QNwoq4hRY3N+ggxj4u2v7e/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pP/Om+RvQa2WK17yYjZG3+2iuOf1DlUhWHqdvPqOYYaMat9q8+IFB9Io3/r1p7M82
	 mhQt7Gqy9NBCnD1WThSQF/ioAybZqsbo9hRmP3SDcM/vrB4Ngx7IlfcxbcGyGtB4/T
	 BIi5z+bxXojHlElSNW0TAOQAF2ICNz8WmjiosTa1njmTwgcHrPSozXyht/RpXBJsMt
	 3skeZXQd9uoafcTRB1AObc5PDzBvnSJ45grXqKrrULquFjAGGT46grbTlWS+wgPTGN
	 3Ux4ommVXxMLuibcDOFnP40vHtpEsgvJiPtgngMKefIGbrQ0q26ILd83Z+7qZbHvOJ
	 nzhG/GXIX3KNg==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: make region calculations more precise
Date: Thu, 22 May 2025 10:16:13 -0700
Message-Id: <20250522171613.57127-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87bjrl9zsi.fsf@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 22 May 2025 09:53:17 +0800 Enze Li <lienze@kylinos.cn> wrote:

> 
> Hi SeongJae,
> 
> On Wed, May 21 2025 at 10:18:09 AM -0700, SeongJae Park wrote:
> 
> > Hi Enze,
> >
> > On Wed, 21 May 2025 15:07:47 +0800 Enze Li <lienze@kylinos.cn> wrote:
[...]
> > If you think this function also deserves a short comment for clarifying this,
> > your patch for that wil be welcomed :)
> 
> Since this is already documented in the definition, repeating it here
> would be redundant.  If someone submits a similar patch for this in the
> future, we can consider adding comments then.

Makes sense!


Thanks,
SJ

[...]
