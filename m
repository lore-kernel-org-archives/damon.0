Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BBB7DA73;
	Tue, 25 Mar 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936478; cv=none; b=MWwVPIT645osW6Vb5a4GZG38XGMmRls4n4wF726YaaeievyfrteMNFZz6EJTgl8nGdLk30Z27STQqSbEg5BdIjjDiAlU56mt8YNBHCwZqvwus8tSCepamQqZWmPxVKJ+GB9jjqWYtOW0BbLwp8yRbuFL7uT1GcJ2ERyiFeTXp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936478; c=relaxed/simple;
	bh=PPWU3l4LCJdB98jPPjw2NNmWLBKLIu9LtckOISw4RA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5bSETZLCH2f/iRn8KNOPpgxkXk9Dp5eY9KWkhgyV0inJoHeMnaa9NPpTZ512maVTG2lFWAdbBQRQnCj00YjgXo+w6rvyK8uscwPD6Fjz+oDLIkAoIscIeH4U8QhoVnzswCkKQy4Whw/mmmwMljUK3/7li6ABrTQmEvLZZNLeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHy01Rzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHy01Rzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7696BC4CEE4;
	Tue, 25 Mar 2025 21:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742936477;
	bh=PPWU3l4LCJdB98jPPjw2NNmWLBKLIu9LtckOISw4RA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHy01RzkeJFnCXZeMmZeCz9KlY7xH2E9N8czzp1uWSqEH4lozSh9g+S2msBefoPep
	 Wwte+jVcwS/N/xbEfJ+Uuy0huSJGCx4MDKS1daaqKkRt25ZoLubavA7d0BQkmy/DgG
	 znc+4jkl8+BBESO/OpPTJG+Px+MJVapzDkh3lXZ3u4q61vpJZF9oc8eTGTkMmRlL2l
	 RG3IwkhX9CJo6dRjcMkHa4cpDnDeDPjeP2BDNEJ8VXR+3AqApzXiFMItzwlb8VMBl0
	 QkbaDFF3VZh19Nxbvk7+kvDBOa2tARLORV4A6QiYKi1bv0T3vGvWozvNYiIr9FNQ74
	 7jJzkonGr6eqA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of Future
Date: Tue, 25 Mar 2025 14:01:13 -0700
Message-ID: <20250325210114.844509-1-sj@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250101222039.74565-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed,  1 Jan 2025 14:20:39 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hi all,
> 
> 
> I find a few interesting and promising projects that aim to do efficient access
> pattern-aware memory management of near future, including below (alphabetically
> sorted).
> 
> - CXL hotness monitoring unit
>   (https://lore.kernel.org/20241121101845.1815660-1-Jonathan.Cameron@huawei.com)
> - Memory tiering fainess by per-cgroup control of promotion and demotion
>   (https://lore.kernel.org/20241108190152.3587484-1-kaiyang2@cs.cmu.edu)
> - Promotion of unmapped page cache folios
>   (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)
> - Slow-tier page promotion based on PTE A bit
>   (https://lore.kernel.org/20241201153818.2633616-1-raghavendra.kt@amd.com)
> - Workingset reporting
>   (https://lore.kernel.org/20241127025728.3689245-1-yuanchu@google.com)
> 
> The goal of DAMON is to help accelerating such developments by being a
> framework that can reduce fundamental efforts for monitoring memory access
> patterns and managing memory using the information.  AWS Aurora Serverless v2
> and SK hynix are successfully using DAMON in the way for proactive memory
> reclamation[1] and CXL memory tiering[2].
> 
> To further deliver such benefits for the ongoing and future projects, we need
> to better understand what the projects really need, how DAMON can provide those
> now or in future, and if there are alternatives better than DAMON.  Regardless
> of the conclusion about DAMON, the works apparently have common parts, so the
> discussion will benefit all.
> 
> I propose to have the discussion at LSF/MM/BPF.  In the session, I will briefly
> introduce the works and possible DAMON usages, and continue the open discussion
> for better understanding each other.  The discussion will not be limited to
> DAMON and abovely mentioned projects but possible alternatives and general
> access-aware memory management projects.  After the discussion, we will
> hopefully find ways to efficiently collaborate, or at least do not disturb each
> other.
> 
> [1] https://assets.amazon.science/ee/a4/41ff11374f2f865e5e24de11bd17/resource-management-in-aurora-serverless.pdf
> [2] https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion

A draft of the slides for this session is now available at
https://github.com/damonitor/talks/blob/master/2025/lsfmmbpf/damon_requirements_lsfmmbpf_2025.pdf

I may make more last time changes to the slides, but the final version should
also be available on the same URL.


Thanks,
SJ

[...]
