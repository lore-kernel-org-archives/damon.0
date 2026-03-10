Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7930E0D6;
	Tue, 10 Mar 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104741; cv=none; b=lmi2z/zusVRIa3DxCmiq3NeuFO++m/BP4rVng8LwyDlcFe3zBqStONCZRKZ00JUb2g5qj+wfxpDqW7NnZX92kerCSNYMRFT5MfIQAY81zwDk45gBlWEkNNLaa1zjSV7fS+Ya1FbKdc6RRXLungDLl9AxQUGxTrdZ9shzqgK718U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104741; c=relaxed/simple;
	bh=pVuHdsiSK2hSc3Y/sliHzMztEBUolq4unjdQPlB02FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9zy0n9Ey6hz7WNjGcV1Eh0gT8ByQtxOfk0Ue0Nztypq00HsGa3lsK3V3PIz6kMzf0+VEjDAudUjH1Wz6jiSRuK8n3pU/yolTH0NQGLf8dWvv6Va1hVvy89b96nmMRPS/LN7qjy/4bSptZ2lVzfAW0y/jM67Y0F1viniPhU8fuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WROYJi3p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WROYJi3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A064C19423;
	Tue, 10 Mar 2026 01:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104741;
	bh=pVuHdsiSK2hSc3Y/sliHzMztEBUolq4unjdQPlB02FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WROYJi3pg0s9YWJLtb+YkNLSNrzNt3u+ZPN0u5lL3irj8Sy28JYveAk4Lu1PnS64o
	 8JI9DNZvmkX8CufiB8zkHDzzB+EmakY92070cqRJWTX4NdIJf3iEnSGR6O6OSONmOB
	 TyuDCBrXCcOl8T4PolU8RlQV+0J1SUX5r1rAEo/i3Em+4dCHZxIcSSIpP/ZTlhxpp4
	 qQaci1MxArBksMyUq2EDe9KhB7UVYn8TVaUatqrYxvnGx8fcW4Cszai3cArqlcmTwO
	 nvWDvL4/UbwL+MYsk00wG7bIf8RpXxJGjzz1unXbzx12hoLVQ/hT4K03FnZuFX9FBw
	 BKwY05JUwjLug==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/11] selftests/damon/drgn_dump_damon_status: support quota goal_tuner dumping
Date: Mon,  9 Mar 2026 18:05:26 -0700
Message-ID: <20260310010529.91162-11-sj@kernel.org>
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

Update drgn_dump_damon_status.py, which is being used to dump the
in-kernel DAMON status for tests, to dump goal_tuner setup status.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 5374d18d1fa8d..af99b07a4f565 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -110,6 +110,7 @@ def damos_quota_to_dict(quota):
         ['reset_interval', int],
         ['ms', int], ['sz', int],
         ['goals', damos_quota_goals_to_list],
+        ['goal_tuner', int],
         ['esz', int],
         ['weight_sz', int],
         ['weight_nr_accesses', int],
-- 
2.47.3
