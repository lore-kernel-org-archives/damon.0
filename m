Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961D79C0
	for <damon@lists.linux.dev>; Wed, 30 Nov 2022 19:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3069C433C1;
	Wed, 30 Nov 2022 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669836398;
	bh=5LR5nZNtSi/Kxu1y5TcusuYTtmflF/F58GD4wz8A6tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SREZe5jdo0z5QVLSdrd5b0OVFXg61U4/Toe+uHLqAu5+dhjXGqEcvPpu5Bf5uzF2f
	 ejG8HkfnDf60Z5/pj8/h6WGr1ajfx6psmvzyv9J7XaH53zaa+ZDnVh8morJRd8r6Gj
	 qT9OPkWumBDYRPx1esRxs+bpOlnEsUGnsWTfzbRpeY3IinzZTKE1d09QKFdKWCAPNt
	 6ao2pdaLZSgdULhCDyCZWVKdw2nL2I7XPvHOT6MfwiG2fZjncbIadndltZhYrgOv1G
	 NsokxYq/ch394MEBS93KP2g/mpcWauv3KfJ7PTrWmLg6IKeUYOuR8rbHM0iDv57eFw
	 daF7L8MIHjN/A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/11] mm/damon/sysfs-schemes: implement scheme filters
Date: Wed, 30 Nov 2022 19:26:36 +0000
Message-Id: <20221130192636.116555-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-9-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Nov 2022 21:21:11 +0000 SeongJae Park <sj@kernel.org> wrote:

> Implement scheme filters functionality of DAMON sysfs interface by
> making the code reads the values of files under the filter directories
> and pass that to DAMON using DAMON kernel API.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs-schemes.c | 85 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 7f2bab617156..6f014b328e6f 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[...]
> +static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
> +{
> +	struct mem_cgroup *memcg;
> +	char *path;
> +
> +	if (!memcg_path)
> +		return -EINVAL;
> +
> +	path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
> +	if (!path)
> +		return -ENOMEM;
> +
> +	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
> +			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
> +		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
> +			*id = mem_cgroup_id(memcg);

Forgot mentioning this.  Removed memcgs can still be iterated, so this can
result in getting id of already removed cgroup.  If the user input is valid but
there is a removed memcg that has same path, this could be confused.

Removed memcg would have id 0.  The next version of this will handle the case.


Thanks,
SJ

> +			break;
> +		}
> +	}
> +
> +	kfree(path);
> +	return 0;
> +}
