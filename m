Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1D4779A1
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397543; cv=none; b=soR9/e1Q0KQTQwg6WN3QUWXlZQIzwGELmuph/YXigb1Tmxc2QRzhslnxH8DZApeItN7/y2IqeJPLOAuGoWDzY3faNNp7iAADjhyNayy8VCC0aziiEPpBV0PLk8PiIDB7BkLc/tgH9VOBGWZdUM+KulEO02vsPndyIezN/s5eJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397543; c=relaxed/simple;
	bh=xZ3PLIoZ/47oXu52R6nM3p0tXgabmO3Ui/16nsJr0zs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WPqFdRj8qCJ2z8kDcXEcqP2VLqUbLzS3gMjNOhn0OaQL3qezpkykTK5hu3YtipccDO6qj0qV/h4M8ChkTPnbaS8wfs1fzmi4tLF32j5Fsw0m07FiDuyAGq+GWKPAGjChpvfFNwRiV2GT4Bwz2K0ZS2jloO26ZHxWh4ulQeFDXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Y4DJzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Y4DJzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671BD1F000FF;
	Mon, 14 Sep 2026 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397537;
	bh=48k3T3qgSLids5Qdm3CN08JBlAqToUrxZE/jS0/2M7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2Y4DJzovrr4orgDEw0jG0q2km85ml2yoxyuqRWs6jortQ+VmXTaNHfvb1o3qDPwH
	 VIeWz7GeFJmMsrLchr09+qTnE9Fz0B+3sTZDXqgHsumuL/0bgYlTp9kilfEQXIqBiz
	 IB9g1b6gpHgD7eLnbOvnDjkJKZ7J7W2r9xaSQQS4tyFmVkCFiBgqWf9h+7SaA4WH39
	 O1Vedg0w9JoIrK9vD3uEeM7hcy/AYDt9VLt9LsytduNzZLChG1RFnvZA2raiovhuB4
	 F0GE8j8Ex+RScuV8CCzhOS4bjPaibW++/Kqxzufg+rxC0FXUhfVsnQFZDmzm+QV3sx
	 HdDj0W2yCc8tw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/8] mm/damon/core: commit hugepage_size type
 damon filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914144448.93732-3-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
 <20260914144448.93732-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:52:16 +0000
Message-Id: <20260914145217.671BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of newly allocated `damon_filter` on the error path =
in `damon_commit_filters()`.
--

commit 5bd56b851690ccc1ea59e5d967224bde8e275c2a
Author: SJ Park <sj@kernel.org>

mm/damon/core: commit hugepage_size type damon filter

Extend data attribute probe filters commit logic for the new hugepage_size
filter type. This updates the size range fields of the commit destination
filter struct and validates the given range.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0c98f7e267d07..ecfe99450e5f0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1838,6 +1848,12 @@ static int damon_commit_filters(struct damon_probe=
 *dst,
>  		case DAMON_FILTER_TYPE_MEMCG:
>  			new_filter->memcg_id =3D src_filter->memcg_id;
>  			break;
> +		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> +			if (src_filter->range_max < src_filter->range_min)
> +				return -EINVAL;

[Severity: Medium]
Does this error path leak the newly allocated new_filter?

It looks like damon_commit_filters() returns early here without adding
new_filter to the destination list or freeing it. Since this is reachable
via the sysfs interface when a user configures a filter with a minimum
larger than the maximum, can this cause a memory leak on invalid input?

> +			new_filter->range_min =3D src_filter->range_min;
> +			new_filter->range_max =3D src_filter->range_max;
> +			break;
>  		default:
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144448.9373=
2-1-sj@kernel.org?part=3D2
