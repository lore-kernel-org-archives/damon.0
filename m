Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D362E9EB5;
	Fri, 27 Jun 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041690; cv=none; b=CDck5qWJSyuZBA9wRG3dggA/vz4jYImGnBT0aV2+zomVHFBTzWGqF53iesss04E/q+VapOg04elZCPEqGH6ILMLVYSR0HojE6DGwnPKyuOif4HuFBgit2gqp1Hj0gEDbt/PRczJ6iF/er7RdAcsxpml8cf5hc+ii5QPx6tF/sd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041690; c=relaxed/simple;
	bh=Uo4uqeLC2fAg4YteLWG/1dxGcCdhab1IQvLYQ8YAAVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwQZm0g/OsYenQoIfQQwG7Ojv6MjDSJpHXbVr96GVrLpYC/C60NrNsmzveYcLvOgiiDXHVEhk/88YolaUB88c/+ql9ZRwlzQaxLK7JOFdiprQLNsUoQ7IKi0mDxFUWTp+dG9jkBcSajZ+SnxcSF6Noj4XO2BhFCQWPzXK1Fm3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpBvjmHZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpBvjmHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD7C4CEE3;
	Fri, 27 Jun 2025 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751041689;
	bh=Uo4uqeLC2fAg4YteLWG/1dxGcCdhab1IQvLYQ8YAAVY=;
	h=From:To:Cc:Subject:Date:From;
	b=WpBvjmHZDV+v5szYIim2tk95ZLAsuUXmY+48hyQ6kxG4KH6Q8zN4iWogd1i/RbQRB
	 0jkBWSwP0xNLfQ2JFwqZBvy0fujqrcHfbRNvql5PPz856kKFzByCsTkJrdta7U+3m0
	 3aUsmZ9uWOvPfvIWWq6zO6In5XHhAn5SeHalGMzQh7UMwYO48gIMUZyYcAVAuH8Qc7
	 LS3/JYS2r0VD+FMxAmwhpl2peOee7bcbWKPCAKZf56OH2FXvBMWEQdxMBQMppgAkXH
	 ugpP74lcoiqaGk5ip+SFNsp11f2ESzORUzg0PunGmGB/WUP8DErt97ZHj/KWo8I6EI
	 kKxXsau7FeA0w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mm-unstable] mm/damon/sysfs-schemes: make damos_sysfs_action_names static
Date: Fri, 27 Jun 2025 09:28:06 -0700
Message-Id: <20250627162806.50589-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6812c66db976 ("mm/damon/sysfs-schemes: decouple from
damos_action") in mm-unstable is defining damos_sysfs_action_names as
non-static, though it is being used only inside sysfs-schemes.c file.
Make it static.

Fixes: 6812c66db976 ("mm/damon/sysfs-schemes: decouple from damos_action") # mm-unstable
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506271655.b8yfEZIT-lkp@intel.com/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5243b94cec24..601360e9b521 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1679,7 +1679,7 @@ struct damos_sysfs_action_name {
 	char *name;
 };
 
-struct damos_sysfs_action_name damos_sysfs_action_names[] = {
+static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
 	{
 		.action = DAMOS_WILLNEED,
 		.name = "willneed",

base-commit: 5de4c740b52ae67feaa1d08690e37e813b2281d5
-- 
2.39.5
