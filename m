Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAE282F1A;
	Wed,  1 Apr 2026 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007172; cv=none; b=jfkP3SVxfEAkaADb4OX3LmZhtbqlHDZySVdmTOUdBcT5BZpz+UzGCDW/5tCuVJisr1I4KVhe1P0XMvpaDHDr+JNOKliXIsCjagQ52TUbG4Mp4lG/8yk7Zvq31X5hWFqVvV0yiogd87sefjDqFHBfQIrdEQleizF4AqIVWd58Wdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007172; c=relaxed/simple;
	bh=jXZfk1mQPfK1IJl13J6c5AH6YpYSd06uZnkSiI5+/Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLF184uA/se0SFTEKr7Hnpo4tiaMzIjBB9Wcxw/KJ9iHjGCG2KeQIfmsEJJuhSO+/2ScBuu4tPzatmH1CBa9J+rJe45o5dX5pFuvpQdJ27bwcqiJE8Vx9xONUsXsCMK32sNRQR/V+Mj5JHqrCi87Vo5RzozRToatmMPwXCzGByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzSGxm/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzSGxm/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885D2C19423;
	Wed,  1 Apr 2026 01:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775007171;
	bh=jXZfk1mQPfK1IJl13J6c5AH6YpYSd06uZnkSiI5+/Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzSGxm/YXsYrSnsIGTiO722hvWDxeLVFmyn0TeukvOA192Z2O0S/92vynODty1E99
	 ooiy23VGQnQsCWlx+SelpYT5euY4WiA0qnUQx/RlqMw/9xgWUGuLNqhODRklf/iOQO
	 k7B1bMGaf5uSK5XGBRX8sy4FaIBczCQmBHnsk89gKZeB21nb3R74Nl0+cw/1J30z6e
	 4jfZXDVQYH12XX0tl3FLXuUyblWplTmwV+18un109j/qti6tNb6mf/CU+Ef0AFCjo/
	 thQqDA2FOayjKvZqU8lbZ2G12iH+Gyq8Qahp5HgcvTIBRdFO5vMRrKcBN/eL2sJDpR
	 vlLcFLidg9qYw==
From: SeongJae Park <sj@kernel.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: fix memory leak on damon_start() failure in damon_stat_start()
Date: Tue, 31 Mar 2026 18:32:49 -0700
Message-ID: <20260401013250.90153-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331101553.88422-1-liu.yun@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ damon@lists.linux.dev.  Please Cc damon@ for all DAMON patches.

Hello Jackie,

On Tue, 31 Mar 2026 18:15:53 +0800 Jackie Liu <liu.yun@linux.dev> wrote:

> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Destroy the DAMON context and reset the global pointer when
> damon_start() fails. Otherwise, the context allocated by
> damon_stat_build_ctx() is leaked, and the stale damon_stat_context
> pointer will be overwritten on the next enable attempt, making the
> old allocation permanently unreachable.
> 
> Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")

As this is a memory leak, let's add Cc: stable@ too.

Cc: <stable@vger.kernel.org> # 6.17.x

> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
