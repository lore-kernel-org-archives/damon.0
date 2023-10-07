Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0F1845
	for <damon@lists.linux.dev>; Sat,  7 Oct 2023 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbv8D4br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B99C433C7;
	Sat,  7 Oct 2023 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696709427;
	bh=EI+Jf8MyoFRrRMDhTXvbJDTwh+ESwYKlXTuaakRtzs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dbv8D4brUV7WGJZolzIPMHeTV5YeDeayiREoz1J72BdJbAs8Osmyg6iRzym6AR8BM
	 MX6vFlyHHpidaODVwIl0EF82M5nA0sj69YH8TClpwIJh7aWfRBa3rLm8rQlugexkm9
	 teawuemJYPXm0hS9+OWrEkw1L+PCvjNpxCBUv6PEd7BCbXPTafyWSw+YoGP0ql3Mjq
	 TsvRiFU8BeWmog7Opy9wDzrYNY6PfMB8915xJU83Pg0wQ+hSIbyZRlpdpItKak91La
	 /mPN5mXFSuVIxBdldqxTCtWTiHxf0u3MhpYWPEFlFpheXGLUvgvL4SGvDqZi1lhN+k
	 VvgOU9jLJbQkQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/damon/sysfs: check DAMOS regions update progress from before_terminate()
Date: Sat,  7 Oct 2023 20:10:24 +0000
Message-Id: <20231007201024.3576-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007200432.3110-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sat, 7 Oct 2023 20:04:32 +0000 SeongJae Park <sj@kernel.org> wrote:

> DAMON_SYSFS can receive DAMOS tried regions update request while kdamond
> is already out of the main loop and before_terminate callback
> (damon_sysfs_before_terminate() in this case) is not yet called.  And
> damon_sysfs_handle_cmd() can further be finished before the callback is
> invoked.  Then, damon_sysfs_before_terminate() unlocks damon_sysfs_lock,
> which is not locked by anyone.  This happens because the callback
> function assumes damon_sysfs_cmd_request_callback() should be called
> before it.  Check if the assumption was true before doing the unlock, to
> avoid this problem.
> 
> Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
> Cc: <stable@vger.kernel.org> # 6.2.x

And this will not cleanly applied to 6.5.y, since this is based on latest
mm-unstable tree.  I will send a backport once this is merged into the
mainline.


Thanks,
SJ

[...]
