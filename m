Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53619BBB
	for <damon@lists.linux.dev>; Fri, 16 Jun 2023 19:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BFBC433C9;
	Fri, 16 Jun 2023 19:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686943068;
	bh=tdsag9TbzOBwZuQPOUhp40y5OC9WFNnEYON6/5U8cj0=;
	h=From:To:Cc:Subject:Date:From;
	b=oEJj2BdDRPkPXY4SNHhOPScW7zA8ioghDK5NMrpk0PJQ0/arpKVZfssjMgsh9k5jO
	 zEbbIC52S5jKtYtbyQ+3sk91O9tbVHQvgf0kGhkZ2OFket6vsM3uCXw/PABHj1fmC4
	 INY/yAazHiSkFIn9tE6ZKGO2o9CqXW6u2DY9EIiix0b5KaEQ4SYRh5I6BonnlPBlbs
	 HGW13EY34TqPM89LK9OjlE678YcTfCe9JesU6TOn2Qo5yAhBeeimqqu8kuvGoO0fPp
	 117e8uxtPtTX3Z8wCO4IOQaj7/zIv6gIPo2rUbCK0KVrO4dFS67v73/Z1I38TET1SZ
	 L+LNtHAS9Mg6Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Docs/{mm,admin-guide}damon: update design and usage docs
Date: Fri, 16 Jun 2023 19:17:35 +0000
Message-Id: <20230616191742.87531-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design and usage documents for outdated and unnecessarily
duplicated parts.

SeongJae Park (7):
  Docs/mm/damon/design: document 'age' of region
  Docs/admin-guide/mm/damon/start: update DAMOS example command
  Docs/admin-guide/mm/damon/usage: fix typos in references and commas
  Docs/admin-guide/mm/damon/usage: remove unnecessary sentences about
    supported address spaces
  Docs/admin-guide/mm/damon/usage: link design document for DAMOS
  Docs/admin-guide/mm/damon/usage: clarify quotas and watermarks sysfs
    interface
  Docs/admin-guide/mm/damon/usage: update the ways for getting
    monitoring results

 Documentation/admin-guide/mm/damon/start.rst |  10 +-
 Documentation/admin-guide/mm/damon/usage.rst | 146 ++++++++-----------
 Documentation/mm/damon/design.rst            |  28 ++++
 3 files changed, 95 insertions(+), 89 deletions(-)

-- 
2.25.1

