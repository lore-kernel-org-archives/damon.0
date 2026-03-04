Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AE39FCB9
	for <damon@lists.linux.dev>; Wed,  4 Mar 2026 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619336; cv=none; b=oq8WM8qDOO9CfUAqb4LSGKnWN1pYZ45cIWx9orhmmgcQuktY3AipqKs3g6M4aVWZ+f+vWDjLSO4brrhtkSHt05yyCxoYg2U0Rk2uL5ewNNTbdwE+AouUUGbYu3CeQ1+AIfNLcF82SgMRpN5tideaKD2P/WHSvkyuFwIy/6BOlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619336; c=relaxed/simple;
	bh=8fEK2GtJ++wMBBCQzSp1x8vrg7ZnwZSQnicWPRc9wbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iR/k0A7RTttg48MKp3HMA8uYY1ypWckqUCug2QZi/0lV1sxUK7MpPQStq1JJ6/dIUDeI9RszC0aLxonv3o9Mk2xhBKNBXiuTZmccwalCsKvt0rRYgbioiNihC0lEsleSLrV6YUW7tEss0bOYqEWxy0xrykBp0nc1tax3GnHy1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQpSC1NygzHnHK7;
	Wed,  4 Mar 2026 18:14:35 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id B08B640086;
	Wed,  4 Mar 2026 18:15:30 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 13:15:30 +0300
Message-ID: <3c9449c1-95c7-4770-8e06-1ee50e263db8@huawei-partners.com>
Date: Wed, 4 Mar 2026 13:15:29 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/10] mm/damon: support multiple goal-based quota
 tuning algorithms
To: SeongJae Park <sj@kernel.org>
CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko
	<mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
	<damon@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260304044122.79394-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SeongJae!

Nice idea for dynamic environments.

On 3/4/2026 7:41 AM, SeongJae Park wrote:
> Aim-oriented DAMOS quota auto-tuning uses a single tuning algorithm.
> The algorithm is designed to find a quota value that should be
> consistently kept for achieving the aimed goal for long term.  It is
> useful and reliable at automatically operating systems that have dynamic
> environments in the long term.
> 
> As always, however, no single algorithm fits all.  When the environment
> has static characteristics or there are control towers in not only the
> kernel space but also the user space, the algorithm shows some
> limitations.  In such environments, users want kernel work in a more
> short term deterministic way.  Actually there were at least two reports
> [1,2] of such cases.
> 
> Extend DAMOS quotas goal to support multiple quota tuning algorithms
> that users can select.  Keep the current algorithm as the default one,
> to not break the old users.  Also give it a name, "consist", as it is
> designed to "consistently" apply the DAMOS action.  And introduce a new
> tuning algorithm, namely "temporal".  It is designed to apply the DAMOS
> action only temporally, in a deterministic way.  In more detail, as long
> as the goal is under-achieved, it uses the maximum quota available.
> Once the goal is over-achieved, it sets the quota zero.

I'm not sure "temporal" is the best name for this type of behaviour.

How about "by_score?". For example, "damos_goal_tune_esz_bp_by_score" and
DAMOS_QUOTA_GOAL_TUNER_BY_SCORE.

> Tests
> =====
> 
> I confirmed the feature is working as expected using the latest version
> of DAMON user-space tool, like below.
> 
>     $ # start DAMOS for reclaiming memory aiming 30% free memory
>     $ sudo ./damo/damo start --damos_action pageout \
>             --damos_quota_goal_tuner temporal \
>             --damos_quota_goal node_mem_free_bp 30% 0 \
>             --damos_quota_interval 1s \
>             --damos_quota_space 100M
> 
> Note that >=3.1.8 version of DAMON user-space tool supports this feature
> (--damos_quota_goal_tuner).  As expected, DAMOS stops reclaiming memory
> as soon as the goal amount of free memory is made.  When 'consist' tuner
> is used, the reclamation was continued even after the goal amount of
> free memory is made, resulting in more than goal amount of free memory,
> as expected.
> 
> Patch Sequence
> ==============
> 
> First four patches implement the features.  Patch 1 extends core API to
> allow multiple tuners and make the current tuner as the default and only
> available tuner, namely 'consist'.  Patch 2 allows future tuners setting
> zero effective quota.  Patch 3 introduces the second tuner, namely
> 'temporal'.  Patch 4 further extends DAMON sysfs API to let users use
> that.
> 
> Three following patches (patches 5-7) update design, usage, and ABI
> documents, respectively.
> 
> Final three patches (patches 8-10) are for adding selftests.  The eighth
> and the ninth patches extend the testing-purpose DAMON sysfs control
> helper and DAMON status dumping tool to support the newly added feature.
> The tenth patch extends the existing online commit test to cover the new
> feature.
> 
> References
> ==========
> 
> [1] https://lore.kernel.org/CALa+Y17__d=ZsM1yX+MXx0ozVdsXnFqF4p0g+kATEitrWyZFfg@mail.gmail.com
> [2] https://lore.kernel.org/20260204022537.814-1-yunjeong.mun@sk.com
> 
> Changelog
> =========
> 
> Changes from RFC v1
> (https://lore.kernel.org/20260212062314.69961-1-sj@kernel.org)
> - Add selftest for goal_tuner commitment.
> - Set goal tuner inside damon_new_scheme().
> - Allow zero size effective size quota.
> - Update the ABI document.
> - Wordsmith change descriptions.
> 
> SeongJae Park (10):
>   mm/damon/core: introduce damos_quota_goal_tuner
>   mm/damon/core: allow quota goals set zero effective size quota
>   mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
>   mm/damon/sysfs-schemes: implement quotas->goal_tuner file
>   Docs/mm/damon/design: document the goal-based quota tuner selections
>   Docs/admin-guide/mm/damon/usage: document goal_tuner sysfs file
>   Docs/ABI/damon: update for goal_tuner
>   selftests/damon/_damon_sysfs: support goal_tuner setup
>   selftests/damon/drgn_dump_damon_status: support quota goal_tuner
>     dumping
>   selftests/damon/sysfs.py: test goal_tuner commit
> 
>  .../ABI/testing/sysfs-kernel-mm-damon         |  6 ++
>  Documentation/admin-guide/mm/damon/usage.rst  | 16 +++--
>  Documentation/mm/damon/design.rst             | 12 ++++
>  include/linux/damon.h                         | 11 ++++
>  mm/damon/core.c                               | 60 +++++++++++++++----
>  mm/damon/sysfs-schemes.c                      | 58 ++++++++++++++++++
>  tools/testing/selftests/damon/_damon_sysfs.py | 12 +++-
>  .../selftests/damon/drgn_dump_damon_status.py |  1 +
>  tools/testing/selftests/damon/sysfs.py        |  7 +++
>  9 files changed, 166 insertions(+), 17 deletions(-)
> 
> 
> base-commit: bbba4ca6322dd5c4f66fe31b1b374f77a8d2b2e5

-- 
Asier Gutierrez
Huawei

