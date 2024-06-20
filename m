Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B873473;
	Thu, 20 Jun 2024 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921022; cv=none; b=e76BbuqfWP75m3aWEMkUkuPAiJMNmOV2Nlx2GY1aPYeKzWt8weHXJH51yPV74A3OCk/8yJGLt+dfl52xx7ybE5U7k9kFxEbEdNuP/HvR320khsHR5+8ingohhFOJKr+WagZGNm5UocOOrHPv3qUfQW94tNm/fkl0fNRv+M3ediQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921022; c=relaxed/simple;
	bh=9A8zsjnWJ3w+ZEMNJXYnlTtNeVnoUfagTA0wT/QCXJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYjmH9CzwFfIR0dEa87TlLsz58PV7uHeCi5XvOm7BcXe9h1rq1KriZ6qaI105OHBXZo90RvoMOQI8Pl/+lRJ0U84qVDfiKIkCZR/NrP2J5gQeUYtOB5B79pBZnZmMMkzT6ZRcNFFcBLhaJ8nM8EJdg8pi/NjHc7NpLRC6kh1muo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIQw8AYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIQw8AYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53142C4AF09;
	Thu, 20 Jun 2024 22:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718921021;
	bh=9A8zsjnWJ3w+ZEMNJXYnlTtNeVnoUfagTA0wT/QCXJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIQw8AYccEDJGoqOG4iYXEsxh/JPCjVFZi5sSi8lWDkjYfeTAdgrQEATt+jopTFE1
	 mf83rCgA0IICAvmJ942ploAHMctLycfLwTmpYaTLsSMcaXcfI1Aji+Y5Zao4tHqhhZ
	 awq1cB1ATzKsG3KZdjwHrAo4JRvWGdyt1J6PYydcH1opg11HNhkX+iZ8xc36564CNK
	 8XKaOYaohaijbnyWQnwzca2YXH9vBRtT+giL2e1xKbl2piNBOUGaEa5YLB1Kookym1
	 lyVHmmMQiSms2zZhU0OGAjqf9uCXC6rCThmSVGYPpVwHl5v0mHfuqBY5JoGs9RYbet
	 lhM3FDIthcQZQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Docs/mm/damon/maintainer-profile: introduce HacKerMaiL
Date: Thu, 20 Jun 2024 15:03:36 -0700
Message-Id: <20240620220337.76942-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620220337.76942-1-sj@kernel.org>
References: <20240620220337.76942-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since DAMON has merged into the mainline, I periodically received some
questions around DAMON's mailing lists based workflow.  The workflow is
not different from the normal ones that well documented, but it is also
true that it is not always easy and familiar for everyone.

I personally overcame it by developing and using a simple tool, named
HacKerMaiL (hkml)[1].  Based on my experience, I believe it is matured
enough to be used for simple workflows like that of DAMON.  Actually
some DAMON contributors and Linux kernel developers other than myself
told me they are using the tool.

As DAMON maintainer, I also believe helping new DAMON community members
onboarding to the worklow is one of the most important parts of my
responsibilities.  For the reason, the tool is announced[2] to support
DAMON community.  To further increasing the visibility of the fact,
document the tool and the support plan on DAMON maintainer's profile.

[1] https://github.com/damonitor/hackermail
[2] https://github.com/damonitor/hackermail/commit/3909dad91301

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 8213cf61d38a..aede61f2d6a8 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -53,6 +53,22 @@ Mon-Fri) in PT (Pacific Time).  The response to patches will occasionally be
 slow.  Do not hesitate to send a ping if you have not heard back within a week
 of sending a patch.
 
+Mailing tool
+------------
+
+Like many other Linux kernel subsystems, DAMON uses the mailing lists
+(damon@lists.linux.dev and linux-mm@kvack.org) as the major communication
+channel.  There is a simple tool called HacKerMaiL (``hkml``) [8]_ , which is
+for people who are not very faimiliar with the mailing lists based
+communication.  The tool could particularly helpful for DAMON community members
+since it is developed and maintained by DAMON maintainer.  The tool is also
+officially announced to support DAMON and general Linux kernel developement
+workflow.
+
+In other words, ``hkml`` [8]_ is a mailing tool for DAMON community, which
+DAMON maintainer is committed to support.  Please feel free to try and report
+issues or feature requests for the tool to the maintainer.
+
 
 .. [1] https://git.kernel.org/akpm/mm/h/mm-unstable
 .. [2] https://git.kernel.org/sj/h/damon/next
@@ -61,3 +77,4 @@ of sending a patch.
 .. [5] https://github.com/awslabs/damon-tests/blob/master/corr/tests/kunit.sh
 .. [6] https://github.com/awslabs/damon-tests/tree/master/corr
 .. [7] https://github.com/awslabs/damon-tests/tree/master/perf
+.. [8] https://github.com/damonitor/hackermail
-- 
2.39.2

