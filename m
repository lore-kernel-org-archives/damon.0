Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1BB16DEA9;
	Tue, 13 Aug 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591323; cv=none; b=MhC212ffTVaxGqDFLKgnC2mwExBr01M0qHfJj4KcKRHMZ1jFwul9gQ8xYGZPTq9wD1tuS7mDNftKskgzCKhPUOleDnXW4c35yoBg5CK1lYQN8Ysa6kN8xWe21zOij6MiGwkLQ7NjMNkFUKHXPxHEEzRjuVodXY3DVKBRnGrSg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591323; c=relaxed/simple;
	bh=dEVQHEmlYte6jQfiIRXpKc329NH2DRM6x6X4PA3hkKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8Q3mGrV+pPbhSYLiY4xkQCDsfhdJl1iPQenMxwlIXDNhBH6nimG63AT1B5GdmLsRMeQbeAdme6FUbW/HAK6E3d6M/4QCpdek39VUkuGvzjYB29aYp5FyR4HxY7my+AtGlFYoZ49h/4XGx27bA6gxJf4UdDPm9iFbS/la7bPUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGZUu0eV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGZUu0eV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F48C32782;
	Tue, 13 Aug 2024 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723591322;
	bh=dEVQHEmlYte6jQfiIRXpKc329NH2DRM6x6X4PA3hkKc=;
	h=From:To:Cc:Subject:Date:From;
	b=FGZUu0eVUlArRqlHoCx/pwwfpfEmQe9vCR4+94T3R/R6ODQstI955RSNOHfUhWY5d
	 enh+SwQJA2V8NQmrmVJ0E8T50IABD48xm0hlpC4fHtzEOetKFrnbYkJWWuxg/QpL8z
	 KrDxHs1Tgw23xWcz18GaBX1xAActmv/I3wlEVonn0iAgVCLCgsXe1D0CuyGR7HPGtz
	 SjNdL3auOr6sZ3HUKKOS2yXopJEv0GnGn5Z/AaCrp5jSMBdGpfcF7xOZJyjrh76T1N
	 fErZG4GCPexhIOaaXeztcV0Futns5G0dvxmyuD02ui7Ws6nGN/MeHsyLFjqN1A2hBd
	 s2qFh2fhewDPg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re:Organizing DAMON GitHub repos (damo, damon-tests, and damoos)
Date: Tue, 13 Aug 2024 16:21:58 -0700
Message-Id: <20240813232158.83903-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello DAMON community,


Current Sitaution
-----------------

We are currently maintaining three repos for non-kernel part of DAMON project,
namely 'damo'[1], 'damon-tests'[2], and 'damoos'[3].  Those under 'awslabs'
organization[4] are currently the main repos for contributors who prefer GitHub
workflow.  That is, such contributors are supposed to send GitHub pull requests
and issue reports to those.  We also have a GitHub organization that is
dedicated for DAMON project and neutral to companies, namely 'damonitor'[5].
The 'damonitor' repos are currently working as mirrors of the 'awslabs' repos.

Upcoming Changes
----------------

We decided to use the 'damonitor' repos as the main repos for GitHub workflow
users.  The transition will be made by 2024-09-05.  Until the date, we will
samely support all the repos.  After the date, we may not be able to actively
respond to GitHub pull requests and issue reports that sent to the 'awslabs'
repos.  Also, source code on 'awslabs' repos might not always be up to date,
and could even be diverged.

Requests to You
---------------

So, if you're using the 'awslabs' repos, please move to 'damonitor' repos by
2024-09-05.  Also, after 2024-09-05, please send GitHub pull requests and issue
reports to only the 'damonitor' repos.

If you have any blocker for these, please reach out to the community via issue
trackers of 'damonitor' repos, sj@kernel.org, damon@lists.linux.dev, and/or
linux-mm@kvack.org.

[1] https://github.com/damonitor/damo
[2] https://github.com/damonitor/damon-tests
[3] https://github.com/damonitor/damoos
[4] https://github.com/awslabs
[5] https://github.com/damonitor


Thanks,
SJ
