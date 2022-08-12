Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABB1FBD
	for <damon@lists.linux.dev>; Fri, 12 Aug 2022 15:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBE9C433D6;
	Fri, 12 Aug 2022 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660319323;
	bh=cvTUSPVXoJaKfemksKrV/He9kW2/6kMVns4u0Rjwb4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUYmnY7lanhhpzrJoziQyLihzTxMt1xP5p04ujfx9cyJTKP8DcRnUv3+Bak3+/Gfd
	 HNHcoqnH2AYZ2+ZlCtR5LuNDF22Uq5TfeYgta0c6W56u5j8b2yHddNaFDilRT+KCVQ
	 6CpsM9ZSQyDzWs27m6VDnF2ZhuoJJjhZn8tuGX4MUSQJz1emqpFfUC3mkxgXokTXBe
	 j4Qv8zDzfv8vHJtWyOrkVruGH8U3Fa+Q4wzcwtwHbQP2BWMXtkPEM6gap1robX1Y8a
	 4U3/01qg7xdenf+PK2QRF+msgtnwAmS1TeiO7U9MMhhwG4KANZZHCKWA3SSETVCOOI
	 9ytSxCl8WKlQQ==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon/core: simplify the parameter passing for region split operation
Date: Fri, 12 Aug 2022 15:48:41 +0000
Message-Id: <20220812154841.116570-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaixu,

On Fri, 12 Aug 2022 15:41:13 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The parameter 'struct damon_target *t' is unnecessary in damon region
> split operation, so we can remove it.

Good finding.  But, 't' is used while 'ctx' is unused in
'damon_split_region_at()' and 'damon_split_regions_of'.  Below code change is
also removing 'ctx', not 't'.  Could you please update the commit message for
that?

Also, please fix the kernel test robot reported issues together:
https://lore.kernel.org/damon/202208121823.8YTRPB1J-lkp@intel.com/


Thanks,
SJ

[...]
