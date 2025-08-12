Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F92FD1BD;
	Tue, 12 Aug 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018804; cv=none; b=luJAhwF66aTtntup8I1CSLYKUxtqE7DqIN7QYFPm4STYBaPfL2L6DIkmw/i5QcBK8NnFTDQPpnmz+gnFyRCdYf2apw8/GDXlDiINTKIY87uTwGiUGd+fdtdZjNfeSVF7Zaupjg0pmD3oj4VytjRvALGBjtr4He5fdOUX6Bz7UeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018804; c=relaxed/simple;
	bh=DDL2bVmixo4qjz0buf9nt8YEqAI27C4kZ9s1B7RDXaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiLzqqeT2iOIisJOQbrnD06AGw1K4ouJvUEAuXBbdihRDpRLx3Vu+hXMBkkwvitSsfPe5hihpS/HWc7Gnr3BGrXTywgB2CXR/oqjwYWGY91/kIVs/HNMJwYj6s2s6KAvw+5j+kiaNMc92/xbycG3s2ug586ix7sHYEGZPgf+4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJEUzrGT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJEUzrGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7793C4CEF0;
	Tue, 12 Aug 2025 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755018803;
	bh=DDL2bVmixo4qjz0buf9nt8YEqAI27C4kZ9s1B7RDXaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJEUzrGT8Q8Oh2evCaX+1T6cWfuLAh9FOBdhc8w07mZxOzdNxo1oTkevmWUDr9NVE
	 ee+TsJCI1KznM+XK6CcNEQRSjuBlr3H/WwyN+htOlPeU1zJxfGqsayu7cbQvsM1w5s
	 zAmVArfjMl7wl8fZEK6x46X54FImdWpETPXFzhPEzMIdrNEdxUuU9Wq6nrjV5bI0KU
	 P+ISMBm7Q2iAbJnHDXSB47/SC2hnDQikyXvTxwAjTeJFC3I0nERpgt+5YBatl/aOHL
	 FZOtaArV6oiOdeMkvkyzeIkdXnX7Iu/Y7b+Z/IUrYPGCNp2J8OaIJvVAuczk6uRkgP
	 SV4//JL7FbqCw==
From: SeongJae Park <sj@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/damon: fix damon selftests by installing _common.sh
Date: Tue, 12 Aug 2025 10:13:21 -0700
Message-Id: <20250812171321.56978-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 08:12:11 +0000 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:

> _common.sh was recently introduced but is not installed and then
> triggers an error when trying to run the damon selftests:
> 
> selftests: damon: sysfs.sh
> ./sysfs.sh: line 4: _common.sh: No such file or directory
> 
> Install this file to avoid this error.
> 
> Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host shared function")

Thank you for catching and fixing this!

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
