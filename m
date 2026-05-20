Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD73E6385
	for <damon@lists.linux.dev>; Wed, 20 May 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286338; cv=none; b=f0U5PWqIAZkNJs4n3NPEXcO4iF3ous/s5pABEHwPlNVF23qqQTzbXcS4YPzn0qIoxqQVFolH2q6rPG4soN7InpYr0EaZyJB7lvWXI/SXCYSuEXu1FjA/eSkIg5//rRL94NDcBItuqmj7cOKgurSaU7KAEInLZA6bLb02Jlc1mI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286338; c=relaxed/simple;
	bh=FiWbUDOZwgevaHdZt97PPzs528zJ1ctRWuK0TSkVN4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/ABLblWUDpP3rgWxugvB1qSAe+xSNVyxe3dlE0lcokTTKsRzinzlTQkwaQWb5pZl09cWk5y9NO/kFfjMw3VnNmuwUP8rldrW/vMgFch9rXUrIHA5RyeS3qBhGjZn+u/vfvzxcaGxQ4XI0URoJu2NGHUQLCTIvnjH2teDzhC4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c901FuZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c901FuZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3441F000E9;
	Wed, 20 May 2026 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779286336;
	bh=+hKiTl5zgzVoAG/F7bVuye7OUoB/iyf68SQHOV1vZlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c901FuZdAWoSKLJary6CJQ1y7BG4wyN17aR5SDPakvmKxRj0otQsRezvoZmXF7BRO
	 kzAQoOGvN0DjtjabRoyNSPUlTh0p4WtB340MOZf/44grkSZlFLgUVjWfQ6e4uGdT4U
	 rtkFgSJKC/PiwYy7uVw7l0eHY59Ni44ec/kkZidGdrdl4rmsXCyNcXCPQsBQV2Fd9R
	 kMxn9BQNSMsghM6OdXhULLaUP10708Jity0sePzmrmCBc5KeRNyXCx5vIxs2XL6/FG
	 b5HFZ+pl+nvhiJuDE5kTKhGnd2AjzZNIuj1YXzMD7d18JdBdpPM9v1A9unhFSe7n9C
	 TauNDb9dkAxtg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 14/14] selftests/damon/sysfs.sh: test pause file existence
Date: Wed, 20 May 2026 07:11:37 -0700
Message-ID: <20260520141138.170194-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520064252.A10C61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 06:42:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added test for the 'pause' file passes the typoed string 'exit' instead of 'exist' to `ensure_file()`, causing the test to silently do nothing.
> --
> 
> commit dfd394f0319e5426a9139ffa02a782a34b43e8ff
> Author: SeongJae Park <sj@kernel.org>
> 
> selftests/damon/sysfs.sh: test pause file existence
> 
> This commit adds a test to ensure the 'pause' sysfs file exists in DAMON's
> sysfs interface.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
> > --- a/tools/testing/selftests/damon/sysfs.sh
> > +++ b/tools/testing/selftests/damon/sysfs.sh
> > @@ -366,6 +366,7 @@ test_context()
> >  	ensure_file "$context_dir/avail_operations" "exit" 400
> >  	ensure_file "$context_dir/operations" "exist" 600
> >  	ensure_file "$context_dir/addr_unit" "exit" 600
> > +	ensure_file "$context_dir/pause" "exit" 600
> 
> [Severity: Medium]
> Is this test unintentionally bypassed? The helper function ensure_file()
> checks for the strings "exist" or "not_exist" to determine what checks
> to perform. Because "exit" is passed instead of "exist", the function
> evaluates neither condition and returns immediately.
> 
> This prevents the test from verifying the file's presence or its
> permissions, causing it to silently do nothing.

Good catch, I will fix this in the next revision.

> 
> >  	test_monitoring_attrs "$context_dir/monitoring_attrs"
> >  	test_targets "$context_dir/targets"
> >  	test_schemes "$context_dir/schemes"
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520062858.167011-1-sj@kernel.org?part=14


Thanks,
SJ
