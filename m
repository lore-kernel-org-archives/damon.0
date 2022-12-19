Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505B63D4
	for <damon@lists.linux.dev>; Mon, 19 Dec 2022 17:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E6C433EF;
	Mon, 19 Dec 2022 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671470293;
	bh=LUvRYJV1lwHcR1CKoJ33hzSQNl//JskrDWF7Xk0nZ9U=;
	h=From:To:Cc:Subject:Date:From;
	b=L9Ti8hzq/ohKuEJ3Nxnn551n8x8Igir27yxd37kcnu3VHM/HGhiaPbM8TlQPhu/TF
	 ytcXF1JOK3I/fCqvFbPws0G9tPNJN3ysVxlOcVMDXtymKTxCbavOqQxKxnh6b+I5Oc
	 bMbTYOlBnqJICSlLIGqR9TQD6LRhdVT60rkNsaMBzVxP6bz6Y0wXeVCPaLMfHPg8+j
	 V3bYeVMNOhCujRKdabMI77MGGX84nK2CHEYGkJMLlJCQs5WUdJGtYd++rHFrNKfPcE
	 awOz5jY7BhBGog+SDUr+4lBndmkSArA9AZjLJpuJ6sQA8pcZGb9MpZrFyWatyCYhBB
	 sDHAWNqj0idpQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 0/2] two fixups for DAMON sysfs' scheme filters support
Date: Mon, 19 Dec 2022 17:18:05 +0000
Message-Id: <20221219171807.55708-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains two fixups of DAMON sysfs' scheme filters
support, which is in mm-unstable.

SeongJae Park (2):
  mm/damon/sysfs-schemes: Fix leaking a filter for wrong cgroup path
  mm/damon/sysfs-schemes: Return an error for filter memcg path id
    lookup failure

 mm/damon/sysfs-schemes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1

