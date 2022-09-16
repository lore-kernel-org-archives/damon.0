Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205819B
	for <damon@lists.linux.dev>; Fri, 16 Sep 2022 16:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4795C433C1;
	Fri, 16 Sep 2022 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663346241;
	bh=vLKW3Gq6muuTLKVz5phR18jx4OuzQbbEePlcPKmt4oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sj+xbk4MXxrHXdhICPcKsreC2faYMsGk+DvIEUmZ9rbxopWBVIaSfPMVS4MB3z0fX
	 bwrOfcnvn2C8tK8+O5zANRFoMd9TfsPZ29Vy8mcAWkIihafPE0Wqe/uHR1Ozko0/ED
	 VKEPQfi+y3MYSLYh5YzaIMKN3a15EjKt44aG2hcNfm+TwQJTiQIcP5v+9QOsBqb2QB
	 01fjiK8lJ1XRuXHnJ+jpHXlmuycYsYLMmCGWRRuMBIO2UejhRsidKd5T2+TgUlEuTw
	 p8Futp9m2xy4jDbtd6JWYYeVDUo2JwXjHEZvZ04qu2y3uSoOsrLnxtdbO+TlFEWjdh
	 TVLGslW9yRcQg==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon: return void from damon_set_schemes()
Date: Fri, 16 Sep 2022 16:37:19 +0000
Message-Id: <20220916163719.17577-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663341635-12675-1-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Sep 2022 23:20:35 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> There is no point in returning an int from damon_set_schemes().
> It always returns 0 which is meaningless for the caller, so
> change it to return void directly.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
