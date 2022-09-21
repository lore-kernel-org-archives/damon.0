Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939866E4
	for <damon@lists.linux.dev>; Wed, 21 Sep 2022 17:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C563BC433D6;
	Wed, 21 Sep 2022 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663781773;
	bh=QaPwob4cmJzkIfhU85aufFwc39FZ/FKzJ0qPTKysOI4=;
	h=From:To:Cc:Subject:Date:From;
	b=WlQAH2wHBfka+mlfQFZ3NASlgKzLaeIK3pvLZyC3UQ/C+ic0h/GdEK+DpNmhbrrLY
	 hN10PFEviF/hd/2rrnWv9AZsaROR5E4gqLCwrXet02Ydh+XLQoK/EOEIuS/LLOfY5H
	 zOvUqYtHyEI4UyzOBZd9cmSv4XlpFOBmcyxL92QIgcAnAtJz9NZdD/5O8zHni0CxPr
	 TjUI3Sjcb03KYXEmGAwMT3ucAnkqG94yIuTlCrjkVLOvv3j9lQEuACAwpBCJSuOqiR
	 mOlR1sK+qQHXKgUSqFE/8vNRQkTycnvudrm0uCAG4xqdPR5IoiKri4N9QuWUn9Wuid
	 0OkBYaN8k3ttA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] Listing all DAMON user-space tools in the Doc
Date: Wed, 21 Sep 2022 17:36:04 +0000
Message-Id: <20220921173604.51794-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


DAMON admin-guide doc[1] is currently listing only DAMO[2] as its user-space
tool.  However, I know there are user-space tools internally using DAMON other
than DAMO.  For example, as I also mentioned in the last week Kernel Summit
talk[3], I know Alibaba has made their own great DAMON user-sapce tool[4].  I,
hence, just thought it might make more sense to give users more selection of
the tools by listing all available DAMON user-space tools on the doc.  Any
thoughts or concerns?

If you don't have a concern but have your own, or know someone's user-space
tools internally using DAMON, and want to list it up on the doc, please let me
know.

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html
[2] https://github.com/awslabs/damo
[3] https://lpc.events/event/16/contributions/1224/
[4] https://github.com/aliyun/data-profile-tools


Thanks,
SJ
