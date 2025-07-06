Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9019D8A3;
	Sun,  6 Jul 2025 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838486; cv=none; b=VP199XPSG3/wRzF2GDhyEMYMX8e0OoJL7fmjcsVA/YaJYEbJzJ+qcy0q8JSXvzeVyl3QhEIFR9CV/l79Kt4MdU3M8z4aTB5tk/8NCjcwy1wHb8D0yUYAnZThLBn5atGk0yqyL+y1B79D4dci50JxVCFEHc0GPW/mXsvb56OtKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838486; c=relaxed/simple;
	bh=hwKHij2hT+j7D7cL+QtR8wgByVkYLZkMpvWNP8v0DXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNyQlhR4AVljjd7pRGy4jHyhiAMZC6w0/UXUDuffxpfL2Tq33gNWhOFh05kk3gpz0oy/g93mZbNfs4N+puPX6jpqSZ1amRaArpljABAyqadfFJ9Sr5p8ibaVheBY4s5wLdIwuQPEuRA60SnxdVvMN8cKj62Uycu02b5opbPgz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgpjT1Rw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgpjT1Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FE6C4CEED;
	Sun,  6 Jul 2025 21:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751838486;
	bh=hwKHij2hT+j7D7cL+QtR8wgByVkYLZkMpvWNP8v0DXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgpjT1RwcOiCmnJQuWHRzBNMEZdKr3SmJ43JmuJ2npnBOnr8HLNcTJ96toR3UftUJ
	 acY5nAywMOdv8lINuVtE+Uf9gT1obmKqAN3+yEd3hInGVbt81CIlxrg86aI0ZcGhRA
	 RDV3mHvxmFhjcLtTlXkQyvLYwYCN7afocfxoGqoK+Q4EqFkvyreywMV/Z05lTZ07jw
	 OUML6woDhrMjNMtggDfmEz1WJIh9ppHIatVYdbBBKDusoTHncdTh7YAhU3seSE3FQv
	 gTPcvUIjOLDG+Az0vQL0gvvAAI9l12YYQk/P5Y/LNJcqElJbboJ8n7UCtqOO7uEiB4
	 Rytb8hM92mp0A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 10/14] mm/damon/vaddr: put pid in cleanup_target()
Date: Sun,  6 Jul 2025 14:48:03 -0700
Message-Id: <20250706214803.56634-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-11-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  6 Jul 2025 13:00:14 -0700 SeongJae Park <sj@kernel.org> wrote:

> Implement cleanup_target() callback for [f]vaddr, which calls put_pid()
> for each target that will be destroyed.  Also remove redundant put_pid()
> calls in core and sysfs, which was required to be done redundantly due
> to the lack of such self cleanup in vaddr.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c  |  2 --
>  mm/damon/sysfs.c | 10 ++--------
>  mm/damon/vaddr.c |  6 ++++++
>  3 files changed, 8 insertions(+), 10 deletions(-)

This patch forgot removing put_pid() from DAMON sample modules.  I will add
below fixup on the next version.


Thanks,
SJ

[...]
---------------------- >8 --------------------------
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index d3215699a5f4..60a84fffed57 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -120,8 +120,6 @@ static void damon_sample_prcl_stop(void)
                damon_stop(&ctx, 1);
                damon_destroy_ctx(ctx);
        }
-       if (target_pidp)
-               put_pid(target_pidp);
 }

 static bool init_called;
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index fb24190d2fc0..82a014c53cec 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -100,8 +100,6 @@ static void damon_sample_wsse_stop(void)
                damon_stop(&ctx, 1);
                damon_destroy_ctx(ctx);
        }
-       if (target_pidp)
-               put_pid(target_pidp);
 }

 static bool init_called;
