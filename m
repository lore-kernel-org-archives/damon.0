Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44F5CA6
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 19:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5CCC433D6;
	Thu,  8 Sep 2022 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662664678;
	bh=4y/gYFIK8fZNCZXf2/aoBtlgEBW3r/vu7ufnJ6SLnj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baZEsFfCF/BU3dYZ6PyVV/s/KTWUWw9Yx1eFiCutXR0stYn8JUfS644nK7an179BM
	 UVXKuB/sNJyxrT2zgwrClPMQpj9NpT6J/whh/LZ1yQ+0EgGbDSrbAgHj0/1+QlKsmo
	 LtDhyRFXWgZL/PSsuNNBVdbi+vU3FahBiOV+qeG1OVFIJHMDnA241WWOMNHrZPo8id
	 o0EqpZoU26bRBKsNxH1WGeEQOn9Jm+mBps80/CL9Ben6hxyHYgAanl9w8s1iLYAEmx
	 vQyc6YwndIYvXvrcul0RuZqhm3x795oaKEdj02zF5KIjsPsAY7Ww3KHJ+RjMHNRIXc
	 dF8kQif0Rj3RA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Yajun Deng <yajun.deng@linux.dev>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: introduce struct damos_access_pattern
Date: Thu,  8 Sep 2022 19:17:56 +0000
Message-Id: <20220908191756.129602-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908184356.103133-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Sep 2022 18:43:56 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Yajun,
> 
> On Thu, 8 Sep 2022 11:26:11 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:
> 
> > The damon_new_scheme() has too many parameters, we can introduce struct
> > damos_access_pattern to simplify it.

Because my previous comments are only for trivial cosmetic nits and the size of
the patch is not tiny, I fixed those on my own and posted it:
https://lore.kernel.org/damon/20220908191443.129534-1-sj@kernel.org/


Thanks,
SJ

[...]
