Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C4277017;
	Tue, 24 Mar 2026 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315713; cv=none; b=ilrxTxd+WYg3wg6UAhgYy8bfL3eweGm+llGdzgdyyZKy+uUvW7n4Z6+gT8eEMEcoqMYOHfnI4xiwV1ZD5ipbbrMNhMuRHLq7pcBrV+iqbDyqU3gbd+eloB1ltVIeM/h81SlgVKVWGh3ClfkDNpz9/86ZQMyM/INrV66rtY2jkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315713; c=relaxed/simple;
	bh=rmjcFzeTy23pBs/opFIoZZhcY+XCN0OAd5iut4rJ2ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiakX2UG6guMq++m2L0uMUCdAqEvXi9q4URbBPFeadpyAxLNIzXyPCHi164y0fVX4k95CuRCEn0h8uztr4hdGvB6VdqmF/s6anhSnZZfmjpEOZt7x5+98EGnJMiDXdrZZDl0INkbCz5VDxoiSKusoRF/2RbZ34i1OzaD99qXJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc96LTuH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc96LTuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BFEC4CEF7;
	Tue, 24 Mar 2026 01:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774315713;
	bh=rmjcFzeTy23pBs/opFIoZZhcY+XCN0OAd5iut4rJ2ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mc96LTuHlsNKdGSIeYbll12sBTSwkK16fnoWSUETZKIphfSwLztwKzwDJ+u8YVf5C
	 CsW357BBv0ftsypLLLD7Pz80UqXSHdhMPeDuVSlbUuYUCrKBTQhUfkalCdMlZLmYpT
	 A8dj7LJ2+9OLtI9TUIH5kcU1MX/Q/TfhHMtj+YSGeLtFnGnEAJgA6hma7zQ/0bjrSF
	 WOoOIAqpXjnEuFhCImriGM3r4I+t5HhRFPvjKkizeBE07AVgreAAGwUDfe4Vmyq5kk
	 5CGVrQ9cDTlOHPijwz3jyqh3C0v2CBttUQT/9/TEoSxzEiFIydgMXBjdZzKvuPphdZ
	 C6SIbJSY3q8Gw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Mon, 23 Mar 2026 18:28:24 -0700
Message-ID: <20260324012825.46899-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260323231538.84452-8-sj@kernel.org
# start of sashiko.dev inline review
commit d9ca6c4a33fc4d613982730edda6f4b67ae30a67
Author: SeongJae Park <sj@kernel.org>
selftests/damon/_damon_sysfs: support pause file staging

This commit adds support for the newly added pause file to the DAMON
test-purpose sysfs interface control Python module.

> diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
> --- a/tools/testing/selftests/damon/_damon_sysfs.py
> +++ b/tools/testing/selftests/damon/_damon_sysfs.py
[ ... ]
>  class DamonCtx:
>      targets = None
>      schemes = None
>      kdamond = None
> +    pause = None
>      idx = None
>  
>      def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
> -            schemes=[]):
> +            schemes=[], pause=False):

This isn't a bug introduced by this patch, but since the function signature
is being modified here, is it a good time to address the mutable default
arguments?

In Python, default arguments are evaluated exactly once at function
definition time. This means any instances of DamonCtx created without
explicitly providing targets, schemes, or monitoring_attrs will share
the same list structures and DamonAttrs instance in memory.

For example, self.monitoring_attrs.context = self overwrites the context
attribute of the shared DamonAttrs object for all default contexts.

Would it be better to change these defaults to None and instantiate them
within the method body to avoid unexpected state sharing across instances?

>          self.ops = ops
>          self.monitoring_attrs = monitoring_attrs
>          self.monitoring_attrs.context = self

# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260323231538.84452-8-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260323231538.84452-8-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
