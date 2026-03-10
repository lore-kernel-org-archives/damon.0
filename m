Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F830BF6C;
	Tue, 10 Mar 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104740; cv=none; b=jVty9BxqwRS5ka9vHeSyYpIrELgKmETEiiNG4FlJ72zh3+qdMdveOROEWQjccMVJAn8zs/C1k+conf0QmU2etU6LINbyzK4JZVy42hHFvvVy3+f5tO5MzlDj72G7HP2/wMpiD0PetFwV3U+2LQ1wuEsqKhh0nyDwt5CRk6mMs3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104740; c=relaxed/simple;
	bh=X4gj60NUP5Gx9WKLfYMZxZSkKyfsCySS7inf5fgIm6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMt0NF6a6k6CtJh69bO+miGg+AneMUU8l1LCb2rc56EMv7EvV8h4nj6XA5B9PCTAvRqiEq0FU+SPYIgtDEPwB2NsPTVsLnxUi9Cy/rTKzA1SXN1ltYwL3d4sMqURWX47rz1vByrOGQ+KkmAYklm4RziM9YBbDpyKKC5aDvY4/hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3rTn648; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3rTn648"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F6CC2BCB1;
	Tue, 10 Mar 2026 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104740;
	bh=X4gj60NUP5Gx9WKLfYMZxZSkKyfsCySS7inf5fgIm6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3rTn648M6dajZCpxKbTycwPJf6G272kVzHHeHbK/Y/CBXrojLvFwyEzlurwCstOg
	 aXpBz5UMcg0Uaw7XOW8Sbl4LHV8DM11G2a3bSoXvU5UBC7bjihk5Ms9kf+ONsrz8L8
	 7HbBRkP7Z84yYcD0yP53BTh0q3R+BfnDwJIhd50V9V10+0sL4HNsjChdKHTIU8sYE0
	 gzUzZboj9P/712G/ilDUCc/8KLis1Q/x1VYUko72qfVX8mKTMjOz4W2BGWwNUW0q8j
	 55CXtl5njcr5pn2P3jRrqB470qWXExSHWqwgBiOfzmUWDa0IYHgvYJcYZZ7K9wFK2y
	 +sLnW0JkmiV3A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/11] Docs/ABI/damon: update for goal_tuner
Date: Mon,  9 Mar 2026 18:05:23 -0700
Message-ID: <20260310010529.91162-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310010529.91162-1-sj@kernel.org>
References: <20260310010529.91162-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the ABI document for the newly added goal_tuner sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index f2af2ddedd323..2424237ebb105 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -316,6 +316,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the path
 		parameter of the goal.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goal_tuner
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		goal-based effective quota auto-tuning algorithm to use.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
