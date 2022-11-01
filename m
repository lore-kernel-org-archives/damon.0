Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731F21D6C
	for <damon@lists.linux.dev>; Tue,  1 Nov 2022 22:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C7CC433D6;
	Tue,  1 Nov 2022 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667340054;
	bh=gP4LqJrYpXjsL/T9scrG8Q+DRiTrpGTd3NYLkmhHrI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRYKIiCTh+nt+jwvEtoepcLF1JLG+o+9vufajBuCbph+kwKeCCVkSG9Kn2bwhMYrE
	 rhAw4A9JPtAn51/Uy1icFcHgU+8iB1m4GP4U6DpTdESd1Vsemld9fbxWFqryzXFjev
	 W1eA34cPWjp1NpNqm649U0yCJmAum92gHpOjbkLZNtDKEFFjiDe4rFPQ+CDiT/LFQb
	 GRWplJx71OhFSuJystQEv++gDi9UfSpL/JN+IOn2ezfkwSdDJ4ZtnflP0FQA4DoCLW
	 7s4nuhJqkb+orDR85juqFSf2TuqH/M9Y+lB2UDiNgCo4ecdyezNj78XrwxvuyH9t4V
	 74TVYCik84+tA==
From: SeongJae Park <sj@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 20/30] mm/damon: Use kstrtobool() instead of strtobool()
Date: Tue,  1 Nov 2022 22:00:53 +0000
Message-Id: <20221101220053.95605-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ed2b46489a513988688decb53850339cc228940c.1667336095.git.christophe.jaillet@wanadoo.fr>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Nov 2022 22:14:08 +0100 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
