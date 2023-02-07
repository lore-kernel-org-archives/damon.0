Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78927733
	for <damon@lists.linux.dev>; Tue,  7 Feb 2023 22:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76DDC433EF;
	Tue,  7 Feb 2023 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675808910;
	bh=0pnhlHgUFS+duPYaJ+ghB1NoXh/J7+EhVyjb0D0gxOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VfWZG7Sg7ohHXC9+JTd8YMCwha+ceyYX0R3lnjfSkDm+AWuWFwtjIdpWfmkSPqw8j
	 rEp4NLFkG6d3mYNZTcTzFg8fi7HoG6SkqRA1SqTkQ9qpgrRs5bED49eSUfUooBlvfC
	 3J91PJWN/wkErtr2q5c4UuDfcvOw5Jkhc1abvvVPyZU+3yG+8zFqNCCpTQVBjbdHc2
	 E7knlD0d23EKuZVL5PvcvjRZOavr+e5tpZixVQQPttL9GqhWNAxYSEFBRfgjiJwjPC
	 YojAlxMEpPQI7ABAvgTy26rX+heSJgmF2BI8kMKMzZoWxZ0YDzWTi27zVPVx0eVLAZ
	 2Q5Da4uQscl+w==
From: SeongJae Park <sj@kernel.org>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: make kobj_type structures constant
Date: Tue,  7 Feb 2023 22:28:27 +0000
Message-Id: <20230207222827.55192-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207-kobj_type-damon-v1-1-9d4fea6a465b@weissschuh.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On Tue, 07 Feb 2023 19:21:15 +0000 "Thomas Weißschuh" <linux@weissschuh.net> wrote:

> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
