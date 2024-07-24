Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74313A24D;
	Wed, 24 Jul 2024 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859685; cv=none; b=WDRYj1m8eBesvsTmmgsX4yj6UXAcmnb+5s75ume3zgk9yOJJxpLXmdvwSOlCe81GjrYU1P7wi9pqEghezWvCvDbmN0YwVfEqik+2fuSigmid91muVOivHoS6+iIgHMao7E2xOjxj6z0mMbhEfhG/KQ/fAa/BviOmHsnEwG6O9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859685; c=relaxed/simple;
	bh=7U/BfhOp1guJ+/v/2bYZDnABsM2iqQV8bcRGFRmsEt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gard+dSrxUb/OTUwN2/suQiFS+4OEGpJij/2v1ZdyGklK4Caam7ncxujaksXxnOZhdlrxhvHaS7MCWDwKC183qgFn60TAULWHkiedJ3FWJHcungHIT3Nl+8GrNu1vWuHmCU0fkd5k3oLBcGuCXryMA0Lx6pK0/3Bsv9QWTI+wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwtWqghm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwtWqghm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F96BC32781;
	Wed, 24 Jul 2024 22:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721859684;
	bh=7U/BfhOp1guJ+/v/2bYZDnABsM2iqQV8bcRGFRmsEt4=;
	h=From:To:Cc:Subject:Date:From;
	b=dwtWqghm/4Ggmzfmjs4vIC8dKLL9yYavoQGgD7XYKM7i9zQzNB41+sbs8TmbIBUUq
	 /yFpuemuiqenTNJCnA7zXkEa2iixIWm4MFafm8uWJh9uej5224vBjIim3CcghTts0Y
	 3tkPV4nd82gVBi/v4248jNwVN8RudwwpWOitPM63HacAwzBCmQMkUQyF/6M0V455Cc
	 Q8wsZVeQd8JZ1pgPg/Y2gS9Odi/DRGDsCCke1l64FTiPHyNASznVKHiP6YFDdbUStP
	 nRWyPxRsQsfUlU3S5Nsini367ZhPGO6K4r2iI1l6b72s3tpaTsL654ma6p/g0VDsjw
	 vH/z3qCvBn3Cg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Call for DAMON Recipies
Date: Wed, 24 Jul 2024 15:21:19 -0700
Message-Id: <20240724222119.58477-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello DAMON community,


As a humble DAMON maintainer, I'm having a privilege to hear many interesting
and creative DAMON usages.  At OSSummit EU 2024, I'm going to share[1] those.
While preparing the talk, I again reminded that my best knowledge is always
only a small part of that of the community.

So I'm asking help to the community for collecting more DAMON recipes.  If you
are using DAMON for any purpose, or know someone who uses DAMON, and if you
think it might be worthy to share, please reach out to me or foward this to
them.  Even if you don't want to share it, or you think it is not worthy to
share, please consider reaching out to me, to make DAMON be more optimzied for
your use case.  You could reply to this email, attend upcoming DAMON
meetups[2], or use whatever you feel most comfortable.

You don't need to unveil anything you don't want to.  If you prefer to, we
could adjust the talk so that you can present your usage directly to the
audiences.

Looking forward to your interesting stories!

And of course, this is not limited to only OSSummit EU.  Depending on responses
to this request, I may think about proposing DAMON microconference to LPC of
next year.

[1] https://sched.co/1ej2S
[2] https://lore.kernel.org/20220810225102.124459-1-sj@kernel.org


Thanks,
SJ
