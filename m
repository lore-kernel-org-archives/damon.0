Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5607C
	for <damon@lists.linux.dev>; Thu, 18 Aug 2022 09:07:54 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1660813672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qf/fOtvxzphZECcP4g0SbRjHJLvM9rnNKj1D8UYOdCU=;
	b=F/jfdAqruc6NZpYfm4kHww/8zt7yCw/PiZesk1jAs3NJOvJangOTjsU6uFj9E7rUxFuXJ7
	5ieJIptdFb3hY8PByLbsyV6cIbEe+VQLfRd7/3vilGT7HAiXeYGmfuEUFVrMwEy4M1YewR
	sJQltiej44aVBe0G2b8tkMrWT8QiJpM=
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mm/damon: replace pmd_huge() with pmd_trans_huge()
 for THP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <a9e010ca5d299e18d740c7c52290ecb6a014dde6.1660805030.git.baolin.wang@linux.alibaba.com>
Date: Thu, 18 Aug 2022 17:07:23 +0800
Cc: sj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <228E21D0-536C-40BC-A21A-52C1762DD2EB@linux.dev>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
 <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
 <a9e010ca5d299e18d740c7c52290ecb6a014dde6.1660805030.git.baolin.wang@linux.alibaba.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev



> On Aug 18, 2022, at 15:37, Baolin Wang <baolin.wang@linux.alibaba.com> =
wrote:
>=20
> The pmd_huge() is usually used to indicate if a pmd level hugetlb,
> however a pmd mapped huge page can only be THP in =
damon_mkold_pmd_entry()
> or damon_young_pmd_entry(), so replacing pmd_huge() with =
pmd_trans_huge()
> in this case to make code more readable according to the discussion =
[1].
>=20
> [1] =
https://lore.kernel.org/all/098c1480-416d-bca9-cedb-ca495df69b64@linux.ali=
baba.com/
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

