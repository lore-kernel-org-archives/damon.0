Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930384DB55C;
	Mon, 31 Aug 2026 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186386; cv=none; b=l140f87naBon+SYFyni/0pYjR7rx24dt3jSeQQZLLp/SJfmCEfXDvgQJVUU+z7K8045efuXHV7O1TxoseyEMlTM62wxHG/OzBSZD7pnwnEpOwy4W5Tn0mmiiZppcCzYt7XqzpyuEK9auPJD3X7PeEg/aifv3x6FYxvzjyFkgd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186386; c=relaxed/simple;
	bh=52AHWpscdkgOxDQC/IjAQGMK4ImVa0aY9Cmu1KeW4SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIBKkoF7vKsBVmYIDqvZreP9OV9xl5zzPXN5J6WbwM7HsgT5FHhSNERjSLpQF2eKymZEHtFWcKz3AoHCOLEGWfUN/3wEjN1fwK7RMw6F9mfXU2GE2t5Z1AG48G5KObwzWsuebnBFpKsI85ZiYVOE5Au8aeb83k+MZTex0q0zzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHlujUnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHlujUnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE011F00ADB;
	Mon, 31 Aug 2026 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186385;
	bh=LAx08zJG2wc5FyCWbkPrWuUIZaKIhJkgRdTbl/CuRIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OHlujUnDKJ74pdai6cyj34+LE81FhNPaOCEGRuPRC+P4PskyejWBBZQFhJuAhAChb
	 I4gC+FZY15URgsc3yuzzBPzMELVnnn4TwdM6CLD3OVYCON+SHDqskaxY5sMs7WaUiQ
	 zVxSe3Gy1Og95VTpniMewDkmQ7RGGiOTa9OcxzhFV61tZTxDGxN/rMYMLps++TPRVr
	 P/HlrMtt+EFaDS2BbFqFAoRJ/SXIfDiCzw+J+73dM1zkagurkzWBzgYGnGBC/Cbg2k
	 uMUhEpkQzQbzv+hReiMYnqPPE20WcTUJ9S1bwFX3+pmNgrXr63UilGtufhXvQ/3zij
	 G8q46AjDIAJNw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hari Mishal <harimishal1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] selftests/damon/sysfs.py: clean up sh processes used for obsolete_target test
Date: Mon, 31 Aug 2026 07:26:06 -0700
Message-ID: <20260831142611.77572-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831142611.77572-1-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hari Mishal <harimishal1@gmail.com>

The obsolete_target test spawns three sh processes and uses their pids
as DAMON monitoring targets.  These processes are never terminated or
waited on, so they are left running (or become zombies) as orphaned
children after the test program exits.

Terminate each process and communicate() with it after the targets are
no longer needed, so it exits and gets reaped instead of being leaked.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20260722012349.9738-1-harimishal1@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.
Changes from v1
- v1: https://lore.kernel.org/20260721190404.135937-1-harimishal1@gmail.com
- Terminate each sh process directly instead of giving it its own stdin
  pipe to close, dropping the stdin=PIPE changes and shrinking the diff.

 tools/testing/selftests/damon/sysfs.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 3ffa054b63867..88a26422ff44c 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -385,6 +385,10 @@ def main():
     assert_ctxs_committed(kdamonds)
     kdamonds.stop()
 
+    for proc in (proc1, proc2, proc3):
+        proc.terminate()
+        proc.communicate()
+
     test_memcg_filter_memcg_path_staging()
 
 if __name__ == '__main__':
-- 
2.47.3
