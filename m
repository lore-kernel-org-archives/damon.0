Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0D1DFF0;
	Sat,  2 May 2026 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777686976; cv=none; b=eKQ7p60MjOCUn7ClwIAqWPIlD3YDV/xdI+iwpIAplpF+Vkc3oFarCya8BnaO5bhbWo2kREc35LLBVBIszSSz0033ffNOvDWq7nNA1JLX+j+7YkhcjVfq1BjEx1vwwRrxGcH10Qg74jH6FXIXvTNsNrYiunbaj5i23gj6MiXbzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777686976; c=relaxed/simple;
	bh=jdf1fy/AOE9duotFUlzo2FacHlWMe7E9VEFUMMiyWis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb1PEpdOLMD5ZpKw2Pc+30E8Z92yxEDhizWop9nEAIuYJAwVRCkwpFFjEOV4CY6UifFHpNCUXVjlfKJ74lfFFeyM7yFcZtmD5glvz69c2Rpj+k6cKUK1//BlW7hsDa8/9j52Ms9cVB+si5ojdSn3XnCueOeBH1os317sBl2C9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9n8A8qg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9n8A8qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF6FC2BCB4;
	Sat,  2 May 2026 01:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777686975;
	bh=jdf1fy/AOE9duotFUlzo2FacHlWMe7E9VEFUMMiyWis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r9n8A8qgFspnzGkNmcw8lKNXv9qFv5CkWJe2p5OEfWitUudHlXaTgBS/Xwe+7OChP
	 1MHbCxT2B+Dak8KTL3Nn+FcZn5FFtrMeEoD1DzS4xo10MEwq/Z2aND4jSzQucs8F/r
	 wNVpn03FrlSss+qcterKGSXHxlkukI3iANmFn/KgwDMojxTh2NyNTwII0/rlis6R5u
	 NznN6tBIi7qsiQpK4Go/nLFdvhzxsOMuStKfcIlSr5ctmoBfvJ+G+2w+6IhxLQXPeC
	 ng+jxYwyxbAH2nKZIGZXTH7u/Vn893hcKvoBaRKWF0FQwRqqqRlBGYudG7P0AigTAP
	 2AF+qQaDDLhYg==
From: SeongJae Park <sj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/11] mm/damon: introduce DAMOS failed region quota charge ratio
Date: Fri,  1 May 2026 18:56:06 -0700
Message-ID: <20260502015607.79341-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <761b47b6-c2f1-4fef-bfab-48ee1d0bbe47@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 1 May 2026 08:49:43 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
[...]
> For Damon Andrew should for now just trust your ACKs. If it has your ACK, it's
> good to go.
> 
> In the future, I expect you would pick up the patches yourself, which is where
> you as the component maintainer would look for any blockers.

FWIW I'm picking DAMON patches to damon/next tree on my own, for my testing and
for a case that Andrew might miss those.

> 
> So for Damon patches I don't think we need the AI review notices from Andrew.

All make sense to me :)


Thanks,
SJ

[...]
