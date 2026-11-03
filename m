Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667589;
	b=LVVXFKVK1cUvRwOcskBix7XWuUIK2ik2ZKMLnKQClL7LTFh+WC05Hcp5JoMmq4OUGy9O
	 vBJoeo7n2nlZuWRBumGwLGWDrWYtH7XieNKYM1Hh66wr5bIbEgDRHINXKGjhm+LYIDO7q
	 EqyoChSNunaUrbgWR7UCvZNt5aaZvlN8q9tSMeRZzf8NtjXjFNqsPTCxOlJ2phAJOECzM
	 RZl1IIxF7Gd8dTC3aM4zXSns4q0S972jtKAKywwdjfuH4+hPC5YKxbRrHso4Dfz4kg17K
	 kK0XZ5mJL103aqAfRHJBWI1oQlCQfczlq2Fxi+ZisDanYlGVd9P90o6lOT8p3+B/YqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wUuIwuuN/5vKEs76XMgA3aQriOe7/CMf19j7+VM0x1U=;
	b=YEaxm/E2piLVRoZOw4hB0JjvUjrYrXdLAhKM+Wj6M6I6lTzK74oXmj1YDAZeluK2XSGo
	 aKiAIo/t4mDc8Ef1haw+a5qNqV6hOaXZSSRf9jfh2yu35uxrAtn3JlKQL9dgtkBFGOgSp
	 wMdZE14Gm5Qj7YfC35zDFn0MR4P0IMR8r4rm7h5HYSwtWViHke1aHpsH4XNYTzdFQqbhS
	 KcSdF5HvvUmpelg2d+REhexeC6WhmXRR2Gp/Y41+9+8voAuO8pwec0EP0KKHt9ePDs6+W
	 yFWVk0jv30asbnCELB8k03S3gklwz8inR4otkHzZFEM0SmrZhzI12Xjj9v6Ivl/qCgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfCTXNo0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2024606A332;
	Tue,  3 Nov 2026 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfCTXNo0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755CD1F00A02;
	Tue,  3 Nov 2026 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667588;
	bh=wUuIwuuN/5vKEs76XMgA3aQriOe7/CMf19j7+VM0x1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfCTXNo0ZPM8K1LgRTrhE8S73NmxzqxhLzmYmP8qsqMgJvPkgdU5m34zUIO+MDX3l
	 pU7qiEvi5XreJoN2NZ+Z6WsvmGOr6pXq60z40hak9Ctmg4QnsgeqqVMczgr/R72pdt
	 ORxeshkRbhxX7mzpYY76p1JSMXo8btnuPMW4mbC9w8EWSLQXiXaQubBQ4kamwbZRBf
	 VnidLDjj23i7+/eW5MQjhG+f/PVV+D7K5GpVZhSWin4nMBTmMO0ODuFasksiTLYjPA
	 YlbdomK4pfJCvhMxfVqcQFi4zMY7WZRc2LAbkRNzTiZyxMTganEklLkbFTmYjcTMrb
	 7NNsd6ntD6izw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Manuel Ebner <manuelebnerli@mailbox.org>
Subject: [PATCH v2 1/8] Docs/admin-guide/mm/damon/start: fix grammar
Date: Mon,  2 Nov 2026 16:59:31 -0800
Message-ID: <20261103005940.91432-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103005940.91432-1-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aveline Noir <jm5905938@gmail.com>

Fix a few grammar slips in the getting-started guide, like "make DAMON
monitors" and a region "that has not accessed".

"The line of the commands" used to be "The first two lines".  With only
one masim line left, I make it "The first line".

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Manuel Ebner <manuelebnerli@mailbox.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index d98b0eb8e7713..e9c77dcddf7d0 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -63,7 +63,7 @@ the execution. ::
 
 The first command of the above example downloads and builds an artificial
 memory access generator program called ``masim``.  The second command asks DAMO
-to start the program via the given command and make DAMON monitors the newly
+to start the program via the given command and make DAMON monitor the newly
 started process.  The third command retrieves the current snapshot of the
 monitored access pattern of the process from DAMON and shows the pattern in a
 human readable format.
@@ -71,16 +71,16 @@ human readable format.
 The first line of the output shows the relative access temperature (hotness) of
 the regions in a single row heatmap format.  Each column on the heatmap
 represents regions of same size on the monitored virtual address space.  The
-position of the column on the row and the number on the column represents the
+position of the column on the row and the number on the column represent the
 relative location and access temperature of the region.  ``[...]`` means
 unmapped huge regions on the virtual address spaces.  The second line shows
 additional information for better understanding the heatmap.
 
 Each line of the output from the third line shows which virtual address range
 (``addr XX size XX``) of the process is how frequently (``access XX %``)
-accessed for how long time (``age XX``).  For example, the eleventh region of
-~9.5 MiB size is being most frequently accessed for last 3.7 seconds.  Finally,
-the fourth command stops DAMON.
+accessed for how long (``age XX``).  For example, the eleventh region of
+~9.5 MiB size is being most frequently accessed for the last 3.7 seconds.
+Finally, the fourth command stops DAMON.
 
 Note that DAMON can monitor not only virtual address spaces but multiple types
 of address spaces including the physical address space.
@@ -95,7 +95,7 @@ monitoring results to a file. ::
     $ ./masim ./configs/zigzag.cfg &
     $ sudo damo record -o damon.data $(pidof masim)
 
-The line of the commands run the artificial memory access
+The first line of the commands runs the artificial memory access
 generator program again.  The generator will repeatedly
 access two 100 MiB sized memory regions one by one.  You can substitute this
 with your real workload.  The last line asks ``damo`` to record the access
@@ -170,8 +170,8 @@ set size has chronologically changed.::
 Data Access Pattern Aware Memory Management
 ===========================================
 
-Below command makes every memory region of size >=4K that has not accessed for
->=60 seconds in your workload to be swapped out. ::
+Below command makes every memory region of size >=4K that has not been accessed
+for >=60 seconds in your workload to be swapped out. ::
 
     $ sudo damo start --damos_access_rate 0 0 --damos_sz_region 4K max \
                       --damos_age 60s max --damos_action pageout \
-- 
2.47.3
