Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCE612F
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 20:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C003BC433D7;
	Fri,  9 Sep 2022 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662755348;
	bh=ayER6vHBJnsSeDv1Q+T6kbhfCJxElLtfrCsQPcSQvis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD8DOEQkHEPiFguPg2q2x1CH6DC+RWF5kt118ZFZ19ZF4+PcPl1PZdCkNz1H836qo
	 B9Ngi6ACuVnbW2X62N2XmVeBamhhZDEjBZKnSqH9eRwt6Pbresu8Xr/emgRLfkZbXS
	 sjMeqfVlkvRdGqK/k7w/F/gLOXxUgDshpjv5kqbZmZDJsumay8YY0z++Q3dEHX/8yZ
	 QmpPzlktA4HvMvZK6PQKZHP/SzezYwxCMVUD+/TIEBK0TGZ65EG1v2tMJGd4YMIa7k
	 DbYfQT+uVbA0nwnW8nY0ED5RBOKJPbTpRsPbgBPu+pSqHQ/fIcHpZY2e7Kj5qHCkB8
	 Bh8DuuDPtC8QQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 6/7] Docs/admin-guide/mm/damon/start: mention the dependency as sysfs instead of debugfs
Date: Fri,  9 Sep 2022 20:29:00 +0000
Message-Id: <20220909202901.57977-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202901.57977-1-sj@kernel.org>
References: <20220909202901.57977-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'Getting Started' document of DAMON says DAMON user-space tool, damo[1],
is using DAMON debugfs interface, and therefore it needs to ensure
debugfs is mounted.  However, the latest version of the tool is using
DAMON sysfs interface.  Moreover, DAMON debugfs interface is going to be
deprecated as announced by commit b18402726bd1
("Docs/admin-guide/mm/damon/usage: document DAMON sysfs interface").

This commit therefore update the document to tell readers about DAMON
sysfs interface dependency instead and never mention about debugfs
interface, which will be deprecated.

[1] https://github.com/awslabs/damo

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 4d5ca2c46288..9f88afc734da 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -29,16 +29,9 @@ called DAMON Operator (DAMO).  It is available at
 https://github.com/awslabs/damo.  The examples below assume that ``damo`` is on
 your ``$PATH``.  It's not mandatory, though.
 
-Because DAMO is using the debugfs interface (refer to :doc:`usage` for the
-detail) of DAMON, you should ensure debugfs is mounted.  Mount it manually as
-below::
-
-    # mount -t debugfs none /sys/kernel/debug/
-
-or append the following line to your ``/etc/fstab`` file so that your system
-can automatically mount debugfs upon booting::
-
-    debugfs /sys/kernel/debug debugfs defaults 0 0
+Because DAMO is using the sysfs interface (refer to :doc:`usage` for the
+detail) of DAMON, you should ensure :doc:`sysfs </filesystems/sysfs>` is
+mounted.
 
 
 Recording Data Access Patterns
-- 
2.25.1

