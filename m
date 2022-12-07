Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07D376
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 01:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6010C433D6;
	Wed,  7 Dec 2022 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670375068;
	bh=9gwl0LY/3FMbEpKl4mJ8EGxqS2Ahze8GFg5DkQ1lXFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nx8dow7qTQelkxuvV+u0My9Ah8byYNPpFh2MzfcY/5IsiC0S1JD8bJQMe/E0YsvN6
	 JMf8VyRP8T7ELx18r8FdupsBAnNDiNS31D5ayi9FbgZJv04VPPF+fjg0Y1NWPAx1l9
	 gJW0GMSMHeXBFyU0MPxABCLd47CEbDG0oTuBq+nEDWMU5ilOxWQWoRmm8rNTV3mYOg
	 grssA3lnRJlbZGVdsZOc2m8o5VGg0GFhGc76pvrDGjY+eHzyKtNd5EF8CDp83EKUrl
	 W9kbKGj9EgZVqDQw8soSembvxkb17CShe8TtmnbwJ+OK386hC7brKi4Dt+z/mF8t1J
	 vvULbIa2FDRKA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date: Wed,  7 Dec 2022 01:04:26 +0000
Message-Id: <20221207010426.146353-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207005624.146281-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 7 Dec 2022 00:56:24 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Vishal,
> 
> 
> Thank you for this patch.
> 
> Nit pick.  Could we please replace 'damon:' on the subject with 'mm/damon:' to
> look more consistent with other DAMON patches?
> 
> On Tue, 6 Dec 2022 16:21:57 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
> 
> > This change replaces 2 calls to compound_head() with one.
> 
> I guess you mean _compound_head() calls in page_folio() that called from
> mark_page_accessed() and folio_mark_accessed().

s/folio_mark_accessed()/deactivate_page()/

Sorry for the typo.


Thanks,
SJ

[...]
