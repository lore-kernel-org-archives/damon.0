Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25226E718;
	Fri,  1 May 2026 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597055; cv=none; b=CBGQW7ohwIS33txXGp/zd30y62Dtb4ZMolm4qIc+ZZFPsUBvgSSGTfu3Nijmp1TKQSngepR1wk8AFlw/awj9Swo62cjqh4zpzKVJSrwHINlEBny7dOPYh8K3nV56k4hz6PTxKWIxwo1+CbkTeCjmlvZ8kxGqIPbOTOOo7KIL+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597055; c=relaxed/simple;
	bh=1IYp1ZgJR/BbgkwxFxDNLAre0KLyvTjycCJgVR8+QvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIoVyTujUYsY1gDoONJwHvKT92MqQShuLcZ6InMxSjPQkKXqYpTUfRPB9fdJ5TNzadxWWa8evizxxClUg9/g0RastMV4yf5kMkFMYMQ8wN7pGFKpDLGnI11ILe6RzIGFszW2WPN+7mzqxu7L0hGDcjixBEB3j++Jy3b2MsNdfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4gjkU8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4gjkU8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDAEC2BCB3;
	Fri,  1 May 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597055;
	bh=1IYp1ZgJR/BbgkwxFxDNLAre0KLyvTjycCJgVR8+QvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4gjkU8oqLUPRx3qGLH8490ENePW9y9lwc3yOXNMHN8H/EgFcNsS6lprkjHWgI25t
	 Ni6TeSbD4U7paeoziYotvpo/8+Jhy6Jlv3xK5ign5rakizymNYvqqj9sEsH7FIOaTC
	 wCbqJpChFWpRQkkEja0p3kS1HcvwneAZk+rgny2N4KEeRVufiIN2urRteJ5VQqOISY
	 Y21k1pNuYwjZmpKROvuupMPSOO6IBWMLoicEnE1gh9cUer17jm6Cy28r5qSFnv0bVH
	 /PHmMwYtDe+1Hd7auk6z2WElzfYlExmypAidPIBL7GDgnyCCCFBCqpYM3WvXzC96sk
	 wJepV5iaSf6bA==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 4/4] Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management documentation
Date: Thu, 30 Apr 2026 17:57:20 -0700
Message-ID: <20260501005721.79301-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430134139.2446417-5-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 Apr 2026 13:41:39 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Add documentation for the DAMON-based Hugepage Management (DAMON_HUGEPAGE)
> feature, which automatically manages huge pages by identifying cold memory
> regions and collapsing them back to regular pages. The documentation covers
> the module's features, operation, and all available module parameters.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  .../admin-guide/mm/damon/hugepage.rst (new)   | 258 ++++++++++++++++++
>  Documentation/admin-guide/mm/damon/index.rst  |   1 +

I will review this after the discussion about whether it should be a sample
module or real world usage module is concluded, as this could be changed a lot
depending on the conclusion.


Thanks,
SJ

[...]
