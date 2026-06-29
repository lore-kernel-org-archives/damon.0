Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C50344D91;
	Mon, 29 Jun 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744417; cv=none; b=h7341XK0OvyUvApiGw/lX3Q4/IWM1Ke+oiH+JGggJJL1PTBFpVEiYLuKofzYtgUmlIZq/oCECtN3i5TOA0nImJ9TkDZph26zU11XXrH9oUVkn1LNAJiR9zHOXJBjnSc6SROJqy+3A4oM9nKivCJxhYzHsEYNea7ufXxQ5YX97Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744417; c=relaxed/simple;
	bh=Dz4+p6bUmje2hlMXfriVSpz5e9WoUqopx3f1h1Y4rPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKptP88e21y/4OGtiTKnpkN5JZk0vnVJKlEicJXi8cpPWlJu5G7GYWatPNgCj+LkANMC36+RCUG4N0edpdG2ILuYN7+eZKjPKRAZaUNoZBqkV8kjqUkYgdwLltRaoHR819cwVEzh1Geo93UYXC6DVLLEr41BqKdi2OxksaQQ+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOwTuXTP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOwTuXTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F081F00A3D;
	Mon, 29 Jun 2026 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744415;
	bh=SHqxec4PhlDUhWE2hLe0q51Y6lQPE2jO7NI1DXylRHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QOwTuXTPpTxb5syY7JY+vsfPfzUsyGM86BJofrBwkokGpq5FI+hTC8foLRNfxcwgV
	 Z9RZH91thQZTFrjaWBQ6t7PnVPhElSuARxW9HQwesSuM7G9y/azD7Iei5hY1OuN+sa
	 EYH9tYOrP1sr1bHW0eEN6JYiOvtVGjVWaZfq37mvV/5Sef1jDPETtl/k45HscxdD8G
	 J05gLP/HYHdZ6yqQysboyd2Wm8h601wvyNb9voDuH9pCLnQ0bULvqO9SD3rY5THSiy
	 jm+XmhGQnT0s481/D1SYFyc824A5UGXnSTv/Agj6MRS0w01adjSdXbPrmXpOcSOlQS
	 lLIEFdhdIQE6Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kunwu Chan <chentao@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Wang Lian <lianux.mm@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/3] selftests/damon/damos_tried_regions: fix expectation output and join TypeError
Date: Mon, 29 Jun 2026 07:46:45 -0700
Message-ID: <20260629144648.134092-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629144648.134092-1-sj@kernel.org>
References: <20260629144648.134092-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

The expectation print has wrong operator precedence: '%' binds
before the conditional expression, so the else branch prints
'not met' without the prefix 'expectation (>= 14) is'.  Add
parentheses to fix it.

Also, '\n'.join() on the list of ints raises TypeError;
convert to str in the list comprehension.

Link: https://lore.kernel.org/20260601032314.424013-3-kunwu.chan@linux.dev
Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <chentao@kylinos.cn>
Cc: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/damos_tried_regions.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/damos_tried_regions.py b/tools/testing/selftests/damon/damos_tried_regions.py
index 3b347eb28bd28..d6472e6a6e082 100755
--- a/tools/testing/selftests/damon/damos_tried_regions.py
+++ b/tools/testing/selftests/damon/damos_tried_regions.py
@@ -55,10 +55,10 @@ def main():
     collected_nr_regions.sort()
     sample = collected_nr_regions[4]
     print('50-th percentile nr_regions: %d' % sample)
-    print('expectation (>= 14) is %s' % 'met' if sample >= 14 else 'not met')
+    print('expectation (>= 14) is %s' % ('met' if sample >= 14 else 'not met'))
     if collected_nr_regions[4] < 14:
         print('full nr_regions:')
-        print('\n'.join(collected_nr_regions))
+        print('\n'.join(['%d' % x for x in collected_nr_regions]))
         exit(1)
 
 if __name__ == '__main__':
-- 
2.47.3
