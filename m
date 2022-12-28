Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F23217
	for <damon@lists.linux.dev>; Wed, 28 Dec 2022 17:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F7CC433D2;
	Wed, 28 Dec 2022 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672249777;
	bh=hoqzlrt+Bcnbtkr/s6+gGCs6GnMG5Com6HGntMhMdSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6ET1zJUrqb6aJrWEt/7qDoVX9Tf1n0xAfZLGr68kaKCg7tGMjdL+1Ro2ecKx+snR
	 o7xhTgIH3D0D9MXGKNYQHkPygmjQBoEm+fR7hL0DjxAUSSW4+m1aa/V0sh5ej5LPoP
	 rTPOBrlCYrQRtJNH5+veJf/YB1D7tCwiTw5CHt8Z7SJA5W+ZFe3qUAEqD4sTjiiJ8L
	 F0M8fsMGm5Er8UJMEllNEVRiMka8rx0eASo/K3q6MsWlAX/fQyoXdjiIjZvb9ntAF1
	 DSMCYLSaE9LAV74GcoPyHhYggHpcYvFcHytWC0OknLIHqnN22wCQgVcN3dxnjC+e8b
	 ZtxUiTl2BJ6Uw==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	vishal.moola@gmail.com,
	willy@infradead.org,
	david@redhat.com
Subject: Re: [PATCH -next v3 6/7] mm/damon: remove unneed damon_get_page()
Date: Wed, 28 Dec 2022 17:49:35 +0000
Message-Id: <20221228174935.89663-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228113413.10329-7-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kefeng,


I forgot mentioning another trivial typo in this patch earlier, sorry.

On Wed, 28 Dec 2022 19:34:12 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> After all damon_get_page() callers are converted to damon_get_folio(),
> remove unneed wrapper damon_get_page().

s/unneed/unneeded/

For above line and the subject of this patch.

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Other than the trivial nit,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
