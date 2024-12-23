Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246138F82;
	Mon, 23 Dec 2024 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985468; cv=none; b=mQgtLYfeXfyZYCOCfgpuTCVa1RBu8Ul+es9wPNg62H7qNbVC1wkjV55TariUBWDwxOEV+sglxR4MSD0LkmA954PIJq44Pl4ZESi6LIGgm/2VuI/ASerzEETBtuhGJaVWbiJNR1zZIeBOmnknB/qmOdMOac1ECDNIG8rCAfeQwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985468; c=relaxed/simple;
	bh=tINgmEfdqpxDJYkousUSj6B1mxODHUGQ462kG9us0Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWqzIwsNjl8yiK+gx+S+cXWWNExjZI5VGlEnOU8LFw8d2R52LM3kXdac3XaTkgYhn4kfdxW3DgZS4oqr9O1ANu8ERD7cNJqghmX3KZR+gVaCoZcsw/JzuwQBqe6ZGR0bhAKnd1R6ccEACkZFxV0zFLyV0/hN0dwtMIO8rYqgcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vI4zMtpF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vI4zMtpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665AEC4CED3;
	Mon, 23 Dec 2024 20:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734985466;
	bh=tINgmEfdqpxDJYkousUSj6B1mxODHUGQ462kG9us0Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vI4zMtpF3PF+96hjQKBmgJuRBBbQE75EtCCNn1Uqb22FTOV9gfxs49LOqkzZ+E/bj
	 E8kT5fOBYSRLK9oIR1MPvsz+GNsG0OjMBAHNGeXviZluhq4qCT1WsP9UQdG50BXXJw
	 aEZoJKAfNpoLpWzfLuYkpDa25gtWvfmC7cxedS5GVgM+m0dev/VlYiNaSOpjMkbytb
	 sEk6nC/PfP1Y0VB5icLueNOQavZ3AeMUfd8tNLkB5BARKkVUMKcfkE3rmBlHy4AKTE
	 ZVS0Oj4rEs7UICP2aIEL4NiywZ96Fuj3vSzyB/2RIm6y+PMAb2j6FDLowiV2kQjUiK
	 4unfWlFeWP3tg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: kernel-team@meta.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/18] mm/damon: enable page level properties based access pattern monitoring
Date: Mon, 23 Dec 2024 12:24:24 -0800
Message-Id: <20241223202424.44704-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Dec 2024 20:03:09 -0800 SeongJae Park <sj@kernel.org> wrote:

> TL; DR
> ======
> 
> This patch series eanble access monitoring based on page level
> properties including their anonymousness, belonging cgroups and
> pg-young-ness, by extending DAMOS stats and regions walk features with
> region-internal DAMOS filters.

I just released DAMON user-space tool, damo, of v2.6.1.  It includes support of
this feature.  Using the user-space tool, I took and shared a simple
screenshot[1] that might help you better understand what users can do with
this.

[1] https://social.kernel.org/notice/ApLdd6IaUEHk3WhgTA


Thanks,
SJ

[...]
